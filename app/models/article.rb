class Article < ActiveRecord::Base
  has_and_belongs_to_many :pages
  has_attached_file :photo, styles: {large: "500x500>", medium: "300x300#", thumb: "100x100#" }
  validates :title, :body, presence: true # add page when working
  validates :title, uniqueness: true
  has_many :comments, dependent: :destroy

  scope :published, -> { where(published: true) }

  # dirty, dirty hack...
  def page_name
    if self.page
      Page.find(self.page).name
    else
      Page.find(1).name
    end
  end
  def color
    'black'
  end

end
