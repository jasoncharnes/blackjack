class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.references :game, null: false, foreign_key: true
      t.references :hand, foreign_key: true
      t.integer :rank, null: false
      t.string :suit, null: false
      t.integer :position

      t.timestamps
    end
  end
end
