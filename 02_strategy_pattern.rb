module ShareStrategy
  def share
    raise NotImplementedError, "Must be overridden in the subclass"
  end
end

module PhoneCameraApp
  attr_accessor :share_strategy

  def set_share_strategy(share_strategy)
    @share_strategy = share_strategy
  end

  def share
    @share_strategy.share
  end

  def take
    puts "Taking the photo"
  end

  def save
    puts "Saving the photo"
  end

  def edit
    raise NotImplementedError, "Must be overridden in the subclass"
  end
end

class Email
  include ShareStrategy

  def share
    puts "I'm emailing the photo"
  end
end

class Social
  include ShareStrategy

  def share
    puts "I'm posting the photo on social media"
  end
end

class Txt
  include ShareStrategy

  def share
    puts "I'm texting the photo"
  end
end

class CameraPlusApp
  include PhoneCameraApp

  def edit
    puts "Advanced photo editing features"
  end
end

class BasicCameraApp
  include PhoneCameraApp

  def edit
    puts "Basic photo editing features"
  end
end

camera_app = BasicCameraApp.new
puts "Share with txt (t), email (e), or social media (s)?"
case gets.chomp
when 't'
  camera_app.set_share_strategy(Txt.new)
when 'e'
  camera_app.set_share_strategy(Email.new)
when 's'
  camera_app.set_share_strategy(Social.new)
else
  camera_app.set_share_strategy(Txt.new)
end

camera_app.take
camera_app.edit
camera_app.save
camera_app.share
