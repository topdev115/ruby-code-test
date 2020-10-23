# frozen_string_literal: true

require_relative 'item'
require_relative 'rule'
require_relative 'checkout'

describe 'Item Class' do
  it 'intialize class with param' do
    instance = Item.new('A', 20)
    expect(instance).to be_instance_of(Item)
  end

  it 'attr_reader' do
    instance = Item.new('A', 20)
    expect(instance.name).to eq('A')
    expect(instance.price).to eq(20)
  end

  it 'raise error without param' do
    expect { Item.new }.to raise_error(ArgumentError)
  end
end

describe 'Rule Class' do
  let(:item) { Item.new('A', 30) }
  it 'intialize class with param' do
    instance = Rule.new(item, 3, 5)
    expect(instance).to be_instance_of(Rule)
  end

  it 'attr_reader' do
    instance = Rule.new(item, 3, 5)
    expect(instance.item).to eq(item)
    expect(instance.limit).to eq(3)
    expect(instance.discount).to eq(5)
  end

  it 'raise error without param' do
    expect { Rule.new }.to raise_error(ArgumentError)
  end
end

# rubocop:disable Metrics/BlockLength
describe 'Checkout Class' do
  let(:items) do
    { a: Item.new('A', 30),
      b: Item.new('B', 20),
      c: Item.new('C', 50),
      d: Item.new('D', 15) }
  end

  let(:rules) do
    [Rule.new(items[:a], 3, 5),
     Rule.new(items[:b], 2, 2.5),
     Rule.new(nil, 150, 20)]
  end

  let(:co) { Checkout.new(rules) }

  it 'intialize class with param' do
    instance = Checkout.new(rules)
    expect(instance).to be_instance_of(Checkout)
  end

  it 'total is 100 when backet is [A, B, C]' do
    co.scan(items[:a])
    co.scan(items[:b])
    co.scan(items[:c])

    expect(co.total).to eq(100)
  end

  it 'total is 110 when backet is [B, A, B, A, A]' do
    co.scan(items[:b])
    co.scan(items[:a])
    co.scan(items[:b])
    co.scan(items[:a])
    co.scan(items[:a])

    expect(co.total).to eq(110)
  end

  it 'total is 155 when backet is [C, B, A, A, D, A, B]' do
    co.scan(items[:c])
    co.scan(items[:b])
    co.scan(items[:a])
    co.scan(items[:a])
    co.scan(items[:d])
    co.scan(items[:a])
    co.scan(items[:b])

    expect(co.total).to eq(155)
  end

  it 'total is 140 when backet is [C, A, D, A, A]' do
    co.scan(items[:c])
    co.scan(items[:a])
    co.scan(items[:d])
    co.scan(items[:a])
    co.scan(items[:a])

    expect(co.total).to eq(140)
  end

  it 'raise error without param' do
    expect { Checkout.new }.to raise_error(ArgumentError)
  end
end
# rubocop:enable Metrics/BlockLength
