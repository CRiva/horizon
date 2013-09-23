class AddAuthorIdAndDueDateToArticle < ActiveRecord::Migration
  def self.up
    add_column(:articles, :author_id, :integer)
    add_column(:articles, :due_date, :datetime)
  end
  def self.down
    remove_column(:articles, :author_id, :integer)
    remove_column(:articles, :due_date, :datetime)
  end
end
