class ArticlePage < ActiveRecord::Migration
  def self.up
    create_table :artices_pages, id: false do |t|
      t.references:page, :article
    end
  end
  def self.down
    drop_table :articles_pages
  end
end
