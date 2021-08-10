class CreateUserDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :user_details do |t|
      t.string  :company_name,              null: false
      t.string  :department_name
      t.string  :name,                      null: false
      t.string  :phone_number,              null: false
      t.references :user,                   null: false, foreign_key: true
      t.timestamps
    end
  end
end
