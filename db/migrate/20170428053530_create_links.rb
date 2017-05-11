class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :given_url
      t.string :slug
      t.integer :clicks
      t.string :title

      t.timestamps
    end
  end
end
