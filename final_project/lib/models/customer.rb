class Customer < ActiveRecord::Base
    has_many :receipts
    has_many :games, through: :receipts
end 