class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :pages
  before_create :setup_role
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
