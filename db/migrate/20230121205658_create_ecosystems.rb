class CreateEcosystems < ActiveRecord::Migration[7.0]
  def change
    create_table :ecosystems do |t|
      t.string :title

      t.timestamps
    end
  end
end
