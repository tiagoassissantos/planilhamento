class User < ApplicationRecord
  enum role: [:admin, :pro_user, :simple_user]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :simple_user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
