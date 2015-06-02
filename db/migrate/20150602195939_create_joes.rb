class CreateJoes < ActiveRecord::Migration
  def change
    create_table :joes do |t|
      t.integer :bob_id

      t.timestamps null: false
    end
  end
end
