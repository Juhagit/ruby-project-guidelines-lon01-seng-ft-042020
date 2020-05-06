class CreateReceipt < ActiveRecord::Migration[4.2]
    def change
        create_table :receipts do |t|
            t.string :customer_id
            t.string :game_id
            t.float :total_price
        end
    end 
end