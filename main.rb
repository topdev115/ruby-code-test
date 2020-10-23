# frozen_string_literal: true
require_relative 'item'
require_relative 'rule'
require_relative 'checkout'

item_a = Item.new('A', 30)
item_b = Item.new('B', 20)
item_c = Item.new('C', 50)
item_d = Item.new('D', 15)

rule_a = Rule.new(item_a, 3, 5)
rule_b = Rule.new(item_b, 2, 2.5)
rule_all = Rule.new(nil, 150, 20)

rules = [rule_a, rule_b, rule_all]

co = Checkout.new(rules)
co.scan(item_a)
co.scan(item_b)
co.scan(item_c)
puts "[A, B, C] = £#{co.total}"

co = Checkout.new(rules)
co.scan(item_b)
co.scan(item_a)
co.scan(item_b)
co.scan(item_a)
co.scan(item_a)
puts "[B, A, B, A, A] = £#{co.total}"

co = Checkout.new(rules)
co.scan(item_c)
co.scan(item_b)
co.scan(item_a)
co.scan(item_a)
co.scan(item_d)
co.scan(item_a)
co.scan(item_b)
puts "[C, B, A, A, D, A, B] = £#{co.total}"

co = Checkout.new(rules)
co.scan(item_c)
co.scan(item_a)
co.scan(item_d)
co.scan(item_a)
co.scan(item_a)
puts "[C, A, D, A, A] = £#{co.total}"
