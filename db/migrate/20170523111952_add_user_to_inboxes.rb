class AddUserToInboxes < ActiveRecord::Migration[5.0]
  def change
    add_reference :inboxes, :user, foreign_key: true
  end
end
