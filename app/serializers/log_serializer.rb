class LogSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :action, :registry, :description, :created_at

  def user_id
    return object.user.name
  end

  def action
    if object.action == 'create'
      return "Criar"

    elsif object.action == 'update'
      return "Atualizar"

    elsif object.action == 'destroy'
      return "Deletar"
    end
  end

  def registry
    if object.registry == 'constructions'
      return "Obra"

    elsif  object.registry == 'construction_stages'
      return "Etapa da Obra"

    elsif  object.registry == 'stage_items'
      return "Item da Etapa"

    elsif  object.registry == 'item_elements'
      return "Elemento do Item"

    elsif  object.registry == 'formats'
      return "Formato"

    elsif  object.registry == 'customers'
      return "Cliente"

    elsif  object.registry == 'registrations'
      return "Usuário"
    end
  end

  def description
    if object.registry == 'item_elements'
      return "Bitola: #{object.description['gauge']}"
    else
      return "Nome: #{object.description['name']}"
    end
  end

end
