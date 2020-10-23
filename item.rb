# frozen_string_literal: true

# Item class
class Item
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
