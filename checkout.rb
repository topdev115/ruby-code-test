# frozen_string_literal: true

# Checkout class
class Checkout
  def initialize(rules)
    @rules = rules
    @basket = []
  end

  def scan(item)
    @basket << item
  end

  def total
    total = basket_total

    @rules.each do |rule|
      if rule.item.nil?
        total -= rule.discount if total >= rule.limit
      else
        items_count = select_item(rule).length
        total -= items_count * rule.discount if items_count >= rule.limit
      end
    end

    total
  end

  private

  def basket_total
    total = 0
    @basket.each { |item| total += item.price }

    total
  end

  def select_item(rule)
    @basket.select { |item| item == rule.item }
  end
end
