class User < ApplicationRecord
  enum role: [:admin, :operator_n1, :operator_n2, :operator_comercial,:operator_marketing, :operator_warranty]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :operator
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
