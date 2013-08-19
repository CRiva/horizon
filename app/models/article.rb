class Article < ActiveRecord::Base
  has_attached_file :photo, styles: {large: "500x500>", medium: "300x300>", thumb: "100x100>" }
  validates :title, :body, :section, presence: true
  validates :title, uniqueness: true
  has_many :comments, dependent: :destroy
end
