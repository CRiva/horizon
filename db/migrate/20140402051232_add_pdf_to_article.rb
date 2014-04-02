class AddPdfToArticle < ActiveRecord::Migration
  def self.up
    add_attachment :articles, :pdf
  end
  def self.down
    remove_attachment :articles, :pdf
  end
end
