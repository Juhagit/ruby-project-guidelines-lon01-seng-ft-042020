class Game < ActiveRecord::Base
    has_many :receipts
    has_many :customers, through: :receipts
end 