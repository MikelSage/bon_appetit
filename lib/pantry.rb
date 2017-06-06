class Pantry
  attr_reader :stock
  def initialize
    @stock = {}
  end

  def stock_check(item)
    if stock.has_key?(item.downcase)
      stock[item.downcase]
    else
      0
    end
  end

  def restock(item, quantity)
    if stock.has_key?(item.downcase)
      stock[item.downcase] += quantity
    else
      stock[item.downcase] = quantity
    end
  end

  def convert_units(recipe)
    new_amounts = {}
    recipe.ingredients.each do |ingredient_name, amount|
      if amount < 1
        new_amounts[ingredient_name] = {quantity: amount * 1000.0,
                                        units: 'Milli-Units'}
      elsif amount > 100
        new_amounts[ingredient_name] = {quantity: amount /100.0,
                                        units: 'Centi-Units'}
      else
        new_amounts[ingredient_name] = {quantity: amount,
                                        units: 'Universal Units'}
      end
    end
    new_amounts
  end
end
