module Duck
  def quack
    raise NotImplementedError, "Must be overridden in the subclass"
  end

  def fly
    raise NotImplementedError, "Must be overridden in the subclass"
  end
end

module Drone
  def beep
    raise NotImplementedError, "Must be overridden in the subclass"
  end

  def spin_rotors
    raise NotImplementedError, "Must be overridden in the subclass"
  end

  def take_off
    raise NotImplementedError, "Must be overridden in the subclass"
  end
end

class DroneAdapter
  include Duck

  attr_accessor :drone

  def initialize(drone)
    @drone = drone
  end

  def quack
    @drone.beep
  end

  def fly
    @drone.spin_rotors
    @drone.take_off
  end
end

class SuperDrone
  include Drone

  def beep
    puts "Beep beep beep"
  end

  def spin_rotors
    puts "Rotors are spinning"
  end

  def take_off
    puts "Taking off"
  end
end

class MallardDuck
  include Duck

  def quack
    puts "Honk honk"
  end

  def fly
    puts "Flap flap"
  end
end

def test_duck(duck)
  duck.quack
  duck.fly
end

mallard_duck = MallardDuck.new
super_drone = SuperDrone.new
drone_adapter = DroneAdapter.new(super_drone)

puts "The duck says..."
test_duck(mallard_duck)

puts "The drone adapter says..."
test_duck(drone_adapter)
