class CreateTwitterNames < ActiveRecord::Migration
  def change
    create_table :twitter_names do |t|
      t.string :name

      t.timestamps
    end
  end
end
