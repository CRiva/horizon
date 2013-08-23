class ChangeSectionColumnInArticlesToPageInt < ActiveRecord::Migration
  def self.up
    remove_column :articles, :section
    add_column :articles, :page, :integer
  end
  def self.down
    add_column :articles, :section, :string
    remove_column :article, :page
  end
end
