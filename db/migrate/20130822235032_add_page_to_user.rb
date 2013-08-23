class AddPageToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :page, :integer
  end
  def self.down
    remove_column :users, :page
  end
end
