class DefaultArticlePublishedToTrue < ActiveRecord::Migration
  def change
    change_column :articles, :published, :boolean, default: true
  end
end
