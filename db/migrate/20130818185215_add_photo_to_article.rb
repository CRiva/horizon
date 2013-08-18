class AddPhotoToArticle < ActiveRecord::Migration
  def self.up
    add_attachment :articles, :photo
  end
  def self.down
    remove_attachment :articles, :photo
  end
end
