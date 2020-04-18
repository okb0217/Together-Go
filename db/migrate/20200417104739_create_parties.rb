class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|

      t.integer :user_id
      t.string :place
      t.string :age
      t.string :people_count
      t.text :introduction
      t.timestamps
    end
  end
end
