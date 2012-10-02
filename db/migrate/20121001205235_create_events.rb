class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.string    :title
      t.string    :preview
      t.datetime  :start_at
      t.timestamps
    end

    add_index :events, [:start_at]

  end


  def down
    drop_table :events
  end
end
