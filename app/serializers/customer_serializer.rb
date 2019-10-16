class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :salesman, :phone, :cpf_cnpj, :created_at, :contact
end
