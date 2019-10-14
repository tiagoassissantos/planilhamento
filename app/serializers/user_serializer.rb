class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :cpf, :role

  def role
    return 'Administrador' if object.role.eql? 'admin'
    return 'Planilhador Pró' if object.role.eql? 'pro_user'
    return 'Planilhador Simples' if object.role.eql? 'simple_user'
  end
end
