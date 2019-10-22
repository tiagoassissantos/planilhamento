class Format < ApplicationRecord
  has_one_attached :format_image

  def to_log
    { id: id, name: name }
  end
end
