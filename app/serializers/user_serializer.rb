class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :cpf, :role

  def role
    return 'Administrador' if object.role.eql? 'admin'
    return 'Operador N1' if object.role.eql? 'operator_n1'
    return 'Operador N2' if object.role.eql? 'operator_n2'
    return 'Operador Comercial' if object.role.eql? 'operator_comercial'
    return 'Operador Marketing' if object.role.eql? 'operator_marketing'
    return 'Operador Pós-Venda / Garantia' if object.role.eql? 'operator_warranty'
  end
end
