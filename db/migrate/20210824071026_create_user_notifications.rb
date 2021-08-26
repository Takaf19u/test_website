class CreateUserNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :user_notifications do |t|
      t.boolean  :other,                     null: false, default: false
      t.boolean  :job,                       null: false, default: false
      t.references :user_detail,             null: false, foreign_key: true
      t.timestamps
    end
  end
end
