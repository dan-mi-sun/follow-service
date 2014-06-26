class CreateFollows < ActiveRecord::Migration
  def up
    create_table(:follows) do |t|
      t.integer :follower_id
      t.integer :followed_id
    end
  end

  def down
    drop_table :follows
  end
end
