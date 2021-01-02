class Pizza
  attr_reader :description

  def initialize
    raise NotImplementedError, "Abstract class: Must be overriden in the subclass"
  end

  def get_description
    description
  end

  def cost
    raise NotImplementedError, "Must be overriden in the subclass"
  end
end

class ThinCrustPizza < Pizza
  def initialize
    @description = "Thin crust pizza"
  end

  def cost
    6.99
  end
end

class ThickCrustPizza < Pizza
  def initialize
    @description = "Thin crust pizza"
  end

  def cost
    8.99
  end
end

class ToppingDecorator < Pizza
  attr_accessor :pizza

  def initialize
    raise NotImplementedError, "Abstract class: Must be overriden in the subclass"
  end

  def description
    raise NotImplementedError, "Must be overriden in the subclass"
  end
end

class Olives < ToppingDecorator
  def initialize(pizza)
    @pizza = pizza
  end

  def get_description
    pizza.get_description + ", olives"
  end

  def cost
    pizza.cost + 0.19
  end
end

class Cheese < ToppingDecorator
  def initialize(pizza)
    @pizza = pizza
  end

  def get_description
    pizza.get_description + ", cheese"
  end

  def cost
    pizza.cost + 0.09
  end
end

class Peppers < ToppingDecorator
  def initialize(pizza)
    @pizza = pizza
  end

  def get_description
    pizza.get_description + ", peppers"
  end

  def cost
    pizza.cost + 0.09
  end
end

thin_crust_pizza = ThinCrustPizza.new
olive_pizza = Olives.new(thin_crust_pizza)
cheesy_olive_pizza = Cheese.new(olive_pizza)
greek_pizza = Peppers.new(cheesy_olive_pizza)
greek_pizza_extra_cheese = Cheese.new(greek_pizza)

puts "#{greek_pizza_extra_cheese.get_description} for $%0.2f" % greek_pizza_extra_cheese.cost
