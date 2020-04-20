class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :session_id, null: false
      t.string :workflow_state
      t.timestamps

      t.index :session_id
    end
  end
end
