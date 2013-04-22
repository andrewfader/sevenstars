class Item < Chingu::GameObject
  attr_accessor :creator, :url
  def initialize options
    location = options[:location]
    creator = options[:creator]
    @level = Gosu::Sample.new("level.wav")

    options = {}
    super(options.merge(image: Gosu::Image["./images/item2.png"]))
    @x = location[0]
    @y = location[1]
    @z = 99999
    update
    getUrl
  end

  def getUrl
    puts "url"
    @url = gets
    @image = Gosu::Image["./images/item.png"]
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
      @image = Gosu::Image["./images/item.png"]
      @y += @image.height
      @last_time = nil
    end
    super
  end

  def open
    if item = $window.item_presence(@x,@y-@old_image.height)
      item.jump
      Launchy.open(item.url)
    end
  end
end
