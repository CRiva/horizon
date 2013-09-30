class Article < ActiveRecord::Base
  belongs_to :pages
  # NOTE: might need to update sizes as the design has changed.
  has_attached_file :photo, styles: {large: "500x500>", medium: "300x300#", thumb: "100x100#" }
  validates :page, :title, :body, :author_id, presence: true
  validates :title, uniqueness: true
  has_many :comments, dependent: :destroy

  scope :published, -> { where(published: true) }

  # dirty, dirty hack...
  def page_name
    if self.page
      Page.find(self.page).name
    else
      return self.page
    end
  end

  def author_name
    if self.author_id
      User.find(self.author_id).name
    else
      'NA'
    end

  end
end
