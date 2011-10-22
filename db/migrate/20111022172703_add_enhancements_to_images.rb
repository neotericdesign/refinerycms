class AddEnhancementsToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :name, :string
    add_column :images, :description, :string
    add_column :images, :caption, :string
    add_column :images, :alt_attribute, :string
    add_column :images, :title_attribute, :string
  end

  def self.down
    remove_column :images, :title_attribute
    remove_column :images, :alt_attribute
    remove_column :images, :caption
    remove_column :images, :description
    remove_column :images, :name
  end
end
