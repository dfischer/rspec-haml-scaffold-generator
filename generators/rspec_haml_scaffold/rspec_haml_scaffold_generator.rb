class RspecHamlScaffoldGenerator < Rails::Generator::NamedBase
  default_options :skip_migration => false
  
  attr_reader   :controller_name,
                :controller_class_path,
                :controller_file_path,
                :controller_class_nesting,
                :controller_class_nesting_depth,
                :controller_class_name,
                :controller_singular_name,
                :controller_plural_name,
                :resource_edit_path,
                :default_file_extension
  alias_method  :controller_file_name,  :controller_singular_name
  alias_method  :controller_table_name, :controller_plural_name

  def initialize(runtime_args, runtime_options = {})
    super

    @controller_name = @name.pluralize

    base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
    @controller_class_name_without_nesting, @controller_singular_name, @controller_plural_name = inflect_names(base_name)

    if @controller_class_nesting.empty?
      @controller_class_name = @controller_class_name_without_nesting
    else
      @controller_class_name = "#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
    end

    @resource_generator = "rspec_haml_scaffold"
    @default_file_extension = "haml"
    @resource_edit_path = "/edit"
    

  end

  def manifest
    record do |m|
      #just so you can see what the variables are
      # => "yoda/bob"
      #p @name # yoda/bob
      #p @controller_name # yoda/bobs
      #p @controller_class_name_without_nesting # Bobs
      #p @controller_class_nesting # yoda
      #p @controller_plural_name #bobs
      #p @controller_singular_name #bobs
      #p @controller_file_path #yoda/bobs
      #p @controller_class_path # ["yoda"]
      
      # Check for class naming collisions.
      m.class_collisions(controller_class_path, "#{controller_class_name}Controller", "#{controller_class_name}Helper")
      m.class_collisions(class_path, "#{class_name}")

      # Controller, helper, views, and spec directories.
      m.directory(File.join('app/models'))
      m.directory(File.join('app/controllers', controller_class_path))
      m.directory(File.join('app/helpers', controller_class_path))
      m.directory(File.join('app/views', controller_class_path, controller_file_name))
      m.directory(File.join('spec/controllers', controller_class_path))
      m.directory(File.join('spec/models'))
      m.directory(File.join('spec/helpers', class_path))
      m.directory File.join('spec/fixtures')
      m.directory File.join('spec/views', controller_class_path, controller_file_name)
      
      # Controller spec, class, and helper.
      m.template 'rspec_haml_scaffold:controller_spec.rb',
        File.join('spec/controllers', controller_class_path, "#{controller_file_name}_controller_spec.rb")

      m.template "rspec_haml_scaffold:controller.rb",
        File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")

      m.template 'rspec_haml_scaffold:helper_spec.rb',
        File.join('spec/helpers', class_path, "#{controller_file_name}_helper_spec.rb")
      
      m.template "#{@resource_generator}:helper.rb",
        File.join('app/helpers', controller_class_path, "#{controller_file_name}_helper.rb")

      for action in scaffold_views
        m.template(
          "rspec_haml_scaffold:view_#{action}_haml.erb",
          File.join('app/views', controller_class_path, controller_file_name, "#{action}.#{default_file_extension}")
        )
      end
      
      # Model class, unit test, and fixtures.
      m.template 'rspec_haml_scaffold:model.rb',      File.join('app/models', "#{@controller_singular_name.singularize}.rb")
      m.template 'model:fixtures.yml',  File.join('spec/fixtures', "#{@controller_singular_name}.yml")
      m.template 'rspec_haml_scaffold:model_spec.rb',       File.join('spec/models', "#{@controller_singular_name}_spec.rb")

      # View specs
      m.template "rspec_haml_scaffold:edit_haml_spec.rb",
        File.join('spec/views', controller_class_path, controller_file_name, "edit.#{default_file_extension}_spec.rb")
      m.template "rspec_haml_scaffold:index_haml_spec.rb",
        File.join('spec/views', controller_class_path, controller_file_name, "index.#{default_file_extension}_spec.rb")
      m.template "rspec_haml_scaffold:new_haml_spec.rb",
        File.join('spec/views', controller_class_path, controller_file_name, "new.#{default_file_extension}_spec.rb")
      m.template "rspec_haml_scaffold:show_haml_spec.rb",
        File.join('spec/views', controller_class_path, controller_file_name, "show.#{default_file_extension}_spec.rb")

      unless options[:skip_migration]
        m.migration_template(
          'rspec_haml_scaffold:migration.rb', 'db/migrate', 
          :assigns => {
            :migration_name => "Create#{singular_name.pluralize.capitalize}",
            :attributes     => attributes
          }, 
          :migration_file_name => "create_#{controller_singular_name.gsub(/\//, '_').pluralize}"
        )
      end

      #m.route_resources controller_file_name
      route_resources name

    end
  end

  protected
    def form_link_for(table_name, singular_name)
      if !@controller_name.split("/")[1].nil?
        return "[:#{@controller_class_nesting.downcase}, @#{singular_name.singularize}]"  
      else
        return "@#{singular_name.singularize}"
      end    
    end
    
    def path_for(singular, plural, txt)
      case txt
      when "show"
        return "#{table_name.singularize}_path(@#{singular_name.singularize})"
      when "edit"
        return "edit_#{table_name.singularize}_path(@#{singular_name.singularize})"
      when "destroy"
        return "#{table_name.singularize}_path(@#{singular_name.singularize}), :confirm => 'Are you sure?', :method => :delete"
      when "index"  
        return "#{table_name}_path"
      end  
    end
    
    # Override with your own usage banner.
    def banner
      "Usage: #{$0} rspec_haml_scaffold ModelName [field:type field:type]"
    end

    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("--skip-migration", 
             "Don't generate a migration file for this model") { |v| options[:skip_migration] = v }
    end

    def scaffold_views
     %w[ index show new edit ]
    end

    def model_name 
      class_name.demodulize
    end

    def route_resources(resource)
      sentinel = 'ActionController::Routing::Routes.draw do |map|'
      logger.route "map.resources #{resource}"
      unless options[:pretend]
        gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
        
           if !resource.split('/')[1].nil? 
             one = resource.split('/')[0]
             two = resource.split('/')[1]
             "#{match}\n  map.namespace(:#{one}) do |#{one}|\n    #{one}.resources :#{two.pluralize}\n  end"
           else
             "#{match}\n  map.resources :#{resource.pluralize}\n"
           end        
    
        end
      end
    end
        
    
    def gsub_file(relative_destination, regexp, *args, &block)
      path = destination_path(relative_destination)
      content = File.read(path).gsub(regexp, *args, &block)
      File.open(path, 'wb') { |file| file.write(content) }
    end
              
end

module Rails
  module Generator
    class GeneratedAttribute
      def default_value
        @default_value ||= case type
          when :int, :integer               then "\"1\""
          when :float                       then "\"1.5\""
          when :decimal                     then "\"9.99\""
          when :datetime, :timestamp, :time then "Time.now"
          when :date                        then "Date.today"
          when :string                      then "\"MyString\""
          when :text                        then "\"MyText\""
          when :boolean                     then "false"
          else
            ""
        end      
      end

      def input_type
        @input_type ||= case type
          when :text                        then "textarea"
          else
            "input"
        end      
      end
    end
  end
end
