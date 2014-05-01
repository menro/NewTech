class CreateInterestFeeds < ActiveRecord::Migration
  def change
    create_table :interest_feeds do |t|
      t.belongs_to :user
      t.references :followable, :polymorphic => true

      t.timestamps
    end
    add_index :interest_feeds, :user_id
  end
end
