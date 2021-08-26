class CreateUserNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :user_notifications do |t|
      t.boolean  :other,                     null: false
      t.boolean  :job,                       null: false
      t.references :user,                    null: false, foreign_key: true
      t.timestamps
    end
  end
end