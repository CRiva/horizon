class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :pages

  has_attached_file :avatar,
                    styles: {
                      medium: "300x300>",
                      thumb: "100x100#",
                      icon: "50X50#"
                    },
                    default_url: "blank_profile.png"
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :name, uniqueness: true
  before_create :setup_role

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  def self.make_all_members
    all.each do |user|
      unless user.role_ids.include?(1)
        user.role_ids = [Role.find_by_name('Member').id]
        user.save!
      end
    end
  end

  def page_name
    if self.page
      Page.find(self.page).name
    else
      ''
    end
  end

  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  private

  def setup_role
    if self.role_ids.empty?
      self.role_ids = [3]
    end
  end
end
