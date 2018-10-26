class AddWinsLossesToPlayers < ActiveRecord::Migration[4.2]
  def change
    add_column :players, :wins, :integer
    add_column :players, :losses, :integer

  end

end
