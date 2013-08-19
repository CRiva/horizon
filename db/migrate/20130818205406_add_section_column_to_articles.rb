class AddSectionColumnToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :section, :string
  end
  def self.down
    remove_column :articles, :section
  end
end
