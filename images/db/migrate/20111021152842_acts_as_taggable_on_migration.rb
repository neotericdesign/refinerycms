class ActsAsTaggableOnMigration < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
    end unless table_exists?('tags')

    create_table :taggings do |t|
      t.references :tag

      # You should make sure that the column created is
      # long enough to store the required class names.
      t.references :taggable, :polymorphic => true
      t.references :tagger, :polymorphic => true

      t.string :context

      t.datetime :created_at
    end unless table_exists?('taggings')

    add_index :taggings, :tag_id unless table_exists?('taggings')
    add_index :taggings, [:taggable_id, :taggable_type, :context] unless table_exists?('taggings')
  end

  def self.down
    # drop_table :taggings
    # drop_table :tags
  end
end
