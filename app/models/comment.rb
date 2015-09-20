class Comment < ActiveRecord::Base
  belongs_to :article
  validates :name, :body, presence: true
end
