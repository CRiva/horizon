class Article < ActiveRecord::Base
  has_attached_file :photo, styles: {large: "500x500>", medium: "300x300#", thumb: "100x100#" }
  validates :title, :body, :section, presence: true
  validates :title, uniqueness: true
  has_many :comments, dependent: :destroy

  scope :published, -> { where(published: true) }

  # dirty, dirty hack...
  def color
    if self.section == "News"
      '#F7977A'
    elsif self.section == "Sports"
      '#82CA9D'
    elsif self.section == "A&E"
      '#8493CA'
    elsif self.section == "Capstone"
      '#F6989D'
    elsif self.section == "OpEd"
      '#82CA9D'
    elsif self.section == "Features"
      '#82CA9D'
    else
      '#A0A0A0'
    end
  end

end
