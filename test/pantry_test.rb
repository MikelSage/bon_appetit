require 'minitest/autorun'
require 'minitest/pride'
require './lib/pantry'
require './lib/recipe'

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

  def test_it_can_check_the_stock_of_a_single_item
    assert_equal 0, pantry.stock_check('Cheese')
  end

  def test_it_can_restock_items
    assert_equal 0, pantry.stock_check('Cheese')

    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check('Cheese')

    pantry.restock('Cheese', 45)

    assert_equal 55, pantry.stock_check('Cheese')
  end

  def test_it_can_convert_ingredient_units
    recipe = Recipe.new("Spicy Cheese Pizza")
    recipe.add_ingredient("Cayenne Pepper", 0.025)
    recipe.add_ingredient("Cheese", 75)
    recipe.add_ingredient("Flour", 500)

    expected = {"Cayenne Pepper" => {quantity: 25, units: "Milli-Units"},
                "Cheese"         => {quantity: 75, units: "Universal Units"},
                "Flour"          => {quantity: 5, units: "Centi-Units"}}

    actual = pantry.convert_units(recipe)

    assert_equal expected, actual
  end
end
