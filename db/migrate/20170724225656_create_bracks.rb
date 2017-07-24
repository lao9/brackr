class CreateBracks < ActiveRecord::Migration[5.0]
  def change
    create_table :bracks do |t|
      t.string :cross_streets
      t.float :lat
      t.float :long
      t.string :owner

      t.timestamps
    end
  end
end
