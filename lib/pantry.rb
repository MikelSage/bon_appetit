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
      if amount % 1 > 0
        units[ingredient] = handle_mixed_units(amount, 1).compact
      elsif amount > 100
        units[ingredient] = handle_mixed_units(amount, 100).compact
      else
        units[ingredient] = [{quantity: amount, units: 'Universal Units'}]
      end
    end
    units
  end

  def handle_mixed_units(amount, divisor)
    amount.divmod(divisor).map do |num|
      if num < 1
        {quantity: (num * 1000.0).round, units: 'Milli-Units'} unless num.zero?
      elsif num < 10 && divisor == 100
        {quantity: num , units: 'Centi-Units'}
      else
        {quantity: num, units: 'Universal Units'}
      end
    end
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
