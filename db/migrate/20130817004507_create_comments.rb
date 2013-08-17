class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :name
      t.text :body

      t.timestamps
    end
  end
  def self.down
    remove_table :commnts
  end
end
