class CreateConstructions < ActiveRecord::Migration[5.2]
  def change
    create_table :constructions do |t|

      t.string :name
      t.string :contact
      t.string :contact_number
      t.string :cpf_cnpj
      t.string :email
      t.belongs_to :customer, index: true
      t.timestamps
    end
  end
end
