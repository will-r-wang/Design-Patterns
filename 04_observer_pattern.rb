module Subject
  def register_observer(observer)
    raise NotImplementedError, "Must be overridden in the subclass"
  end

  def remove_observer(observer)
    raise NotImplementedError, "Must be overridden in the subclass"
  end

  def notify_observers
    raise NotImplementedError, "Must be overridden in the subclass"
  end
end

module Observer
  def update(value)
    raise NotImplementedError, "Must be overridden in the subclass"
  end

  def display
    raise NotImplementedError, "Must be overridden in the subclass"
  end
end

class WeatherStation
  include Subject

  attr_accessor :observers, :temperature, :wind_speed, :pressure

  def initialize(value)
    @observers = Array.new
  end

  def register_observer(observer)
    @observers << observer
  end

  def remove_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each { |observer| observer.update(@temperature, @wind_speed, @pressure) }
  end

  def set_values(temperature, wind_speed, pressure)
    @temperature = temperature
    @wind_speed = wind_speed
    @pressure = pressure
    notify_observers
  end
end

class UserInterface
  include Observer

  attr_accessor :temperature, :wind_speed, :pressure, :subject

  def initialize(subject)
    @subject = subject
    subject.register_observer(self)
  end

  def update(temperature, wind_speed, pressure)
    @temperature = temperature
    display
  end

  def display
    puts "It's #{@temperature} degrees outside."
  end
end

class Logger
  include Observer

  attr_accessor :temperature, :wind_speed, :pressure, :subject

  def initialize(subject)
    @subject = subject
    subject.register_observer(self)
  end

  def update(temperature, wind_speed, pressure)
    @temperature = temperature
    @wind_speed = wind_speed
    @pressure = pressure
    display
  end

  def display
    puts "Current weather conditions: temperature=#{@temperature}, wind speed=#{@wind_speed}, pressure=#{@pressure}"
  end
end

class Alert
  include Observer

  attr_accessor :pressure, :subject

  def initialize(subject)
    @subject = subject
    subject.register_observer(self)
  end

  def update(temperature, wind_speed, pressure)
    @pressure = pressure
    display
  end

  def display
    puts "Alert: Pressure is higher than expected (#{@pressure})" if @pressure > 5
  end
end

weather_station = WeatherStation.new(0)
user_interface = UserInterface.new(weather_station)
logger = Logger.new(weather_station)
alert = Alert.new(weather_station)

puts "Displaying values..."
weather_station.set_values(20, 15, 19)
puts "\nDisplaying values..."
weather_station.remove_observer(user_interface)
weather_station.set_values(0, 15, 1)
puts "\nDisplaying values..."
another_logger = Logger.new(weather_station)
weather_station.set_values(0, 15, 1)
