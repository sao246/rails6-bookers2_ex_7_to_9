class FixRelationships < ActiveRecord::Migration[6.1]
  def change
    remove_reference :relationships, :follower
    remove_reference :relationships, :followed
    add_reference :relationships, :follower, type: :integer, foreign_key: { to_table: :users }
    add_reference :relationships, :followed, type: :integer, foreign_key: { to_table: :users }
  end
end
