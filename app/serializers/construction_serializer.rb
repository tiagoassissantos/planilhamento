class ConstructionSerializer < ActiveModel::Serializer
  attributes :id, :name, :contact, :contact_number, :cpf_cnpj, :email, :created_at

  belongs_to :customer
end
