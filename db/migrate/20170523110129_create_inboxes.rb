class CreateInboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :inboxes do |t|
      t.text :shortmessage
      t.integer :sender
      t.integer :reseiver
      t.boolean :read

      t.timestamps
    end
  end
end
