class ChangeDataTypeForImageFileSize < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE the_table
        ALTER COLUMN image_file_size TYPE integer 
        USING (trim(image_file_size)::integer);
    SQL
  end
end