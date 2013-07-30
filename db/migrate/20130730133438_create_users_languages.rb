class CreateUsersLanguages < ActiveRecord::Migration
  def change
    create_table :users_languages do |t|
      t.belongs_to :user
      t.belongs_to :language

      t.timestamps
    end
    add_index :users_languages, :user_id
    add_index :users_languages, :language_id
  end
end
