class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string    :title
      t.string    :preview
      t.datetime  :start_at
      t.timestamps
    end
  end
end
