class CreateScores < ActiveRecord::Migration[7.0]
  def change
    create_table :scores do |t|
      t.string :participant, null: false
      t.string :trophies, array: true
      t.timestamps
    end
  end
end
