class UserPage < ActiveRecord::Migration
  def self.up
    create_table :pages_users, id: false do |t|
      t.references:page, :user
    end
  end
  def self.down
    drop_table :page_users
  end
end
