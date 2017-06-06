require 'minitest/autorun'
require 'minitest/pride'
require './lib/pantry'
require './lib/recipe'
require "pry"

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

  def test_it_can_check_its_shopping_list_and_it_starts_empty
    assert_instance_of Hash, pantry.shopping_list
    assert pantry.shopping_list.empty?
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

    expected = {"Cayenne Pepper" => [{quantity: 25, units: "Milli-Units"}],
                "Cheese"         => [{quantity: 75, units: "Universal Units"}],
                "Flour"          => [{quantity: 5, units: "Centi-Units"}]}

    actual = pantry.convert_units(recipe)

    assert_equal expected, actual
  end

  def test_it_can_add_items_to_shopping_list
    recipe = Recipe.new("Cheese Pizza")
    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)

    recipe_2 = Recipe.new("Spaghetti")
    recipe_2.add_ingredient("Noodles", 10)
    recipe_2.add_ingredient("Sauce", 10)
    recipe_2.add_ingredient("Cheese", 5)

    expected = {"Cheese" => 20, "Flour" => 20}

    pantry.add_to_shopping_list(recipe)

    assert_equal expected, pantry.shopping_list

    pantry.add_to_shopping_list(recipe_2)

    expected = {"Cheese" => 25, "Flour" => 20, "Noodles" => 10, "Sauce" => 10}

    assert_equal expected, pantry.shopping_list
  end

  def test_some_helper_method
    expected = [{:quantity=>5, :units=>"Centi-Units"},
                {:quantity=>50, :units=>"Universal Units"}]

    assert_equal expected, pantry.handle_mixed_units(550, 100)

    expected = [{quantity: 1, units: "Universal Units"},
                {quantity: 25, units: "Milli-Units"}]

    assert_equal expected, pantry.handle_mixed_units(1.025, 1)
  end
end
