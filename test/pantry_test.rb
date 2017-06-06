require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  attr_reader :pantry
  def setup
    @pantry = Pantry.new
  end

  def test_it_exists
    assert_instance_of Pantry, pantry
  end

  def test_it_can_check_its_stock_and_it_starts_empty
    assert_instance_of Hash, pantry.stock
    assert pantry.stock.empty?
  end

  def test_it_can_check_stock_of_item
    
  end
end
