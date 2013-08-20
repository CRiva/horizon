class Article < ActiveRecord::Base
  has_attached_file :photo, styles: {large: "500x500>", medium: "300x300>", thumb: "100x100>" }
  validates :title, :body, :section, presence: true
  validates :title, uniqueness: true
  has_many :comments, dependent: :destroy

  scope :published, lambda {{conditions: ['published =?', true]}}
  # dirty, dirty hack...
  scope :news, lambda {{conditions: ['section =?', 'News']}}
  scope :sports, lambda {{conditions: ['section =?', 'Sports']}}
  scope :aande, lambda {{conditions: ['section =?', 'A&E']}}
  scope :capstone, lambda {{conditions: ['section =?', 'Capstone']}}
  scope :oped, lambda {{conditions: ['section =?', 'OpEd']}}
  scope :features, lambda {{conditions: ['section =?', 'Features']}}
end
