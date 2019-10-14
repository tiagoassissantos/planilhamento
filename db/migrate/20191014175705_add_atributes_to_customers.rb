class AddAtributesToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :salesman, :string
    add_column :customers, :customer_phone, :string
    add_column :customers, :cpf_cnpj, :string
  end
end
