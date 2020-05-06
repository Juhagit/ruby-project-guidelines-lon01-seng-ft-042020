class CreateCustomers < ActiveRecord::Migration[4.2]
    def change
        create_table :customers do |t|
            t.string :username
            t.string :password
            t.float :balance
        end
    end
end