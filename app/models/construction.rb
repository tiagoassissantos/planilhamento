class Construction < ApplicationRecord
  belongs_to :customer
  has_many :construction_stages, dependent: :destroy

  def to_log
    { id: id, name: name }
  end
end
