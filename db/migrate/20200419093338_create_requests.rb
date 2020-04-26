class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|

    	t.integer :user_id
		  t.integer :party_id
      t.references :partner_user, foreign_key: { to_table: :users }
    	t.references :partner_party, foreign_key: { to_table: :parties }
    	t.timestamps
    end
  end
end
