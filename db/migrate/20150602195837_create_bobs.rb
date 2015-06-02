class CreateBobs < ActiveRecord::Migration
  def change
    create_table :bobs do |t|

      t.timestamps null: false
    end
  end
end
