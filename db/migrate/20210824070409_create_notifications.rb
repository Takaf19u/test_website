class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string  :title,                     null: false
      t.text    :content,                   null: false
      t.integer    :tag,                    null: false
      t.references :administrator,          null: false, foreign_key: true
      t.timestamps
    end
  end
end
