class DropBookComments < ActiveRecord::Migration[6.1]
  def change
    drop_table :book_comments
  end
end
