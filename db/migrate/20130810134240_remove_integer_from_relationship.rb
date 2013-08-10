class RemoveIntegerFromRelationship < ActiveRecord::Migration
  def change
  	remove_column :relationships, :integer, :string
  	remove_column :relationships, :follower_id, :string
  	add_column :relationships, :follower_id, :integer
  end
end
