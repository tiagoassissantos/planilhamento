class ItemElementSerializer < ActiveModel::Serializer
  belongs_to :format

  attributes :id, :position, :gauge, :quantity, :format_values, :weight, 
             :format, :created_at, :sequential
end
