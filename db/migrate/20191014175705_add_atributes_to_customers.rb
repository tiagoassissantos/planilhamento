class AddAtributesToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :salesman, :string
    add_column :customers, :phone, :string
    add_column :customers, :cpf_cnpj, :string
    add_column :customers, :contact, :string
  end
end
