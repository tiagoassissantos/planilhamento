class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :cpf, :role

  def role
    return 'Administrador' if object.role.eql? 'admin'
    return 'Operador Líder' if object.role.eql? 'operator_n1'
    return 'Operador' if object.role.eql? 'operator_n2'
  end
end
