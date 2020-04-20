class CreateHands < ActiveRecord::Migration[6.0]
  def change
    create_table :hands do |t|
      t.references :game, null: false, foreign_key: true
      t.boolean :dealer, default: false, null: false
      t.string :workflow_state

      t.timestamps
    end
  end
end
