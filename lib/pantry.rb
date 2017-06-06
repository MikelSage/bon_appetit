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
end
