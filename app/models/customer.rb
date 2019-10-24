class Customer < ApplicationRecord
  def to_log
    { id: id, name: name }
  end
end
