class RemovePlayersNickname < ActiveRecord::Migration[4.2]
  def change
    remove_column :players, :nickname
  end
end
