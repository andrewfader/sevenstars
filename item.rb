require 'uri'
class Item < Chingu::GameObject
  attr_accessor :creator, :url
  def initialize options
    location = options[:location]
    @level = Gosu::Sample.new("level.wav")

    options = {}
    super(options.merge(image: Gosu::Image["./images/item.png"]))
    @x = location[0]
    @y = location[1]
    @z = 99999
    update
  end

  def self.presence itemx,itemy
    check_range = 20
    self.all.find do |item|
      (itemx-check_range..itemx+check_range).include?(item.x) && (itemy-check_range..itemy+check_range).include?(item.y)
    end
  end

  def jump
    unless @last_time
      @level.play
      @y -= @image.height
      @image = Gosu::Image["./images/item3.png"]
      @last_time = Gosu::milliseconds()
    end
  end

  def update
    if @last_time && (Gosu::milliseconds - @last_time) >= 230
      @image = Gosu::Image["./images/item2.png"]
      @y += @image.height
      @last_time = nil
    end
    super
  end

end
