class Pantry
  attr_reader :stock, :shopping_list

  def initialize
    @stock = {}
    @shopping_list = {}
  end

  def stock_check(item)
    if stock.has_key?(item)
      stock[item]
    else
      0
    end
  end

  def restock(item, quantity)
    if stock.has_key?(item)
      stock[item] += quantity
    else
      stock[item] = quantity
    end
  end

  def convert_units(recipe)
    units = {}
    recipe.ingredients.each do |ingredient, amount|
      if amount < 1
        units[ingredient] = {quantity: amount * 1000.0, units: 'Milli-Units'}
      elsif amount > 100
        units[ingredient] = {quantity: amount /100.0, units: 'Centi-Units'}
      else
        units[ingredient] = {quantity: amount, units: 'Universal Units'}
      end
    end
    units
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each do |ingredient, amount|
      if shopping_list.has_key?(ingredient)
        shopping_list[ingredient] += amount
      else
        shopping_list[ingredient] = amount
      end
    end
  end

  def print_shopping_list
    list = shopping_list.to_a.reduce("") do |string, pair|
      string << "* #{pair[0]}: #{pair[1]}\n"
    end
    puts list
  end
end
