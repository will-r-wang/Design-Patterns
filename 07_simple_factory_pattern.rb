class Zone
  attr_accessor :display_name, :offset
end

class ZonePacific < Zone
  def initialize
    @display_name = "US/Pacific"
    @offset = -8
  end
end

class ZoneMountain < Zone
  def initialize
    @display_name = "US/Mountain"
    @offset = -7
  end
end

class ZoneCentral < Zone
  def initialize
    @display_name = "US/Central"
    @offset = -6
  end
end

class ZoneEastern < Zone
  def initialize
    @display_name = "US/Eastern"
    @offset = -5
  end
end

class ZoneFactory
  def create_zone(zone_id)
    case zone_id
    when "US/Pacific"
      ZonePacific.new
    when "US/Mountain"
      ZoneMountain.new
    when "US/Central"
      ZoneCentral.new
    when "US/Eastern"
      ZoneEastern.new
    else
      nil
    end
  end
end

class Calendar
  def initialize
    raise NotImplementedError, "Abstract class: Must be overriden in the subclass"
  end

  def print
    puts "--- #{@zone.display_name} Calendar ---"
    puts "Offset from GMT: #{@zone.offset}"
  end

  def create_calendar
    raise NotImplementedError, "Must be overriden in the subclass"
  end
end

class PacificCalendar < Calendar
  def initialize(zone_factory)
    @zone = zone_factory.create_zone("US/Pacific")
  end

  def create_calendar
    puts "Creating the calendar"
  end
end

zone_factory = ZoneFactory.new
calendar = PacificCalendar.new(zone_factory)
calendar.create_calendar
calendar.print
