class AddArticleState < ActiveRecord::Migration
  def change
    add_column :articles, :aasm_state, :string, default: 'new'
  end
end
