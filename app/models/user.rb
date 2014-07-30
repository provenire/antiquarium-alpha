class User < ActiveRecord::Base
  # Attributes
  #  - name
  #  - email
  #  - role
  #  - ...
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable # :confirmable, :timeoutable
  
  
  
  def admin?
    self.role == 'admin'
  end

end
