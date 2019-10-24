class FormatSerializer < ActiveModel::Serializer
  attributes :id, :name, :sides, :image_name, :created_at
end
