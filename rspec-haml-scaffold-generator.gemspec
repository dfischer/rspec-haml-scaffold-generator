# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspec-haml-scaffold-generator}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zach Inglis", "Daniel Fischer"]
  s.date = %q{2009-05-06}
  s.email = %q{zach@lt3media.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "generators/USAGE",
    "generators/rspec_haml_scaffold/rspec_haml_scaffold_generator.rb",
    "generators/rspec_haml_scaffold/templates/INSTALL",
    "generators/rspec_haml_scaffold/templates/controller.rb",
    "generators/rspec_haml_scaffold/templates/controller_spec.rb",
    "generators/rspec_haml_scaffold/templates/edit_haml_spec.rb",
    "generators/rspec_haml_scaffold/templates/helper.rb",
    "generators/rspec_haml_scaffold/templates/helper_spec.rb",
    "generators/rspec_haml_scaffold/templates/index_haml_spec.rb",
    "generators/rspec_haml_scaffold/templates/migration.rb",
    "generators/rspec_haml_scaffold/templates/model.rb",
    "generators/rspec_haml_scaffold/templates/model_spec.rb",
    "generators/rspec_haml_scaffold/templates/new_haml_spec.rb",
    "generators/rspec_haml_scaffold/templates/show_haml_spec.rb",
    "generators/rspec_haml_scaffold/templates/view_edit_haml.erb",
    "generators/rspec_haml_scaffold/templates/view_index_haml.erb",
    "generators/rspec_haml_scaffold/templates/view_new_haml.erb",
    "generators/rspec_haml_scaffold/templates/view_show_haml.erb"
  ]
  s.homepage = %q{http://github.com/zachinglis/rspec-haml-scaffold-generator}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Generate RSpec/HAML scaffolds.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
