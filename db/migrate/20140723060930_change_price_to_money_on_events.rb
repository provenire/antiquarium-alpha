class ChangePriceToMoneyOnEvents < ActiveRecord::Migration
  def change
    remove_money  :events, :price
    add_money     :events, :price
  end
end
