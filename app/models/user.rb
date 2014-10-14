class User < ActiveRecord::Base
  # Attributes
  #  - name
  #  - email
  #  - role
  #  - ...
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, #:validatable,
         :lockable # :confirmable, :timeoutable
  
  
  validates :email, uniqueness: true
  
  
  # Activity
  include PublicActivity::Model
  activist
  
  def activities
    self.activities_as_owner
  end
  
  def admin?
    self.role == 'admin'
  end

end
