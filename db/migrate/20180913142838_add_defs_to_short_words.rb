class AddDefsToShortWords < ActiveRecord::Migration[5.0]
  def change
    add_column(:shortwords, :defs, :array)
  end
end
