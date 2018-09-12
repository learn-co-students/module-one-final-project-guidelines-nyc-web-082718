class RenameCharacterEnvironmentsTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :characterenvironments, :character_environments
  end
end
