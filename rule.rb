# frozen_string_literal: true

# Rule class
class Rule
  attr_reader :item, :limit, :discount

  def initialize(item, limit, discount)
    @item = item
    @limit = limit
    @discount = discount
  end
end
