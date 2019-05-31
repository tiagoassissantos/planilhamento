class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :cpf, :role

  def role
    return 'Administrador' if object.role.eql? 'admin'
    return 'Operador Líder' if object.role.eql? 'leading_operator'
    return 'Operador' if object.role.eql? 'operator'
  end
end
