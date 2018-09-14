class RenameColumnInCharacters < ActiveRecord::Migration[5.0]
  def change
    rename_column :characters, :sleep, :sleep_stat
  end
end
