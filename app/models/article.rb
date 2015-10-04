class Article < ActiveRecord::Base
  AVERAGE_WPM = 150.freeze

  belongs_to :pages
  has_many :comments, dependent: :destroy

  is_impressionable :counter_cache => true, :column_name => :impressions_count

  scope :published, -> { where(published: true) }
  scope :on, ->(page_id) { where(page: page_id) }
  validates :page, :title, :body, :author_name, presence: true
  validates :title, uniqueness: true

  has_attached_file :pdf, styles: {
                      thumb: ['100x100#', :jpg],
                      medium: ['300x300#', :jpg],
                      large: ['500x500#', :jpg]
                    }

  validates_attachment :pdf, content_type: {
                         content_type: 'application/pdf'
                       }

  has_attached_file :photo, styles: {
                      large: '500x500>',
                      medium: '300x300#',
                      thumb: '100x100#'
                    }

  validates_attachment_content_type :photo, content_type:
                                              ['image/jpeg',
                                               'image/png',
                                               'image/gif']

  def self.search(search)
    q = "%#{search}%"
    published.where("author_name LIKE ? OR title LIKE ?", q, q)
  end

  def page_name
    Page.find(self.page).name
  end

  def read_time
    read_time = (self.body.split.count / AVERAGE_WPM)
    if read_time >= 1
      return ("Time to read: " + read_time.to_s + " minutes")
    else
      return "Time to read: less than a minute"
    end
  end
end
