class <%= migration_name.classify.pluralize %> < ActiveRecord::Migration
  def self.up
    create_table :<%= singular_name.pluralize %> do |t|
<% for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end %>
      t.timestamps 
    end
  end

  def self.down
    drop_table :<%= singular_name.pluralize %>
  end
end