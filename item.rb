require 'uri'
class Item < Chingu::GameObject
  attr_accessor :creator, :url
  def initialize options
    location = options[:location]
    creator = options[:creator]
    @level = Gosu::Sample.new("level.wav")

    options = {}
    super(options.merge(image: Gosu::Image["./images/item.png"]))
    @x = location[0]
    @y = location[1]
    @z = 99999
    update
    getUrl
  end

  def getUrl
    puts "url"
    url = gets

    if url =~ URI::regexp
      begin
        @url = URI(url).to_s
        @text = Chingu::Text.new("#{@creator}\n#{@url}", x: @x + 5, y: @y + 5, zorder: 999999, factor_x: 2.0)
      rescue URI::InvalidURIError
        puts 'invalid url'
        self.destroy
        @image = nil
      end
    else
      puts 'invalid url'
      self.destroy
      @image = nil
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
      @image = Gosu::Image["./images/item.png"]
      @y += @image.height
      @last_time = nil
    end
    super
  end

  def open
    if item = $window.item_presence(@x,@y-@old_image.height)
      item.jump
      if item.url
        begin
          Launchy.open(item.url)
        rescue Launchy::ApplicationNotFoundError
          puts 'no application'
          self.destroy
          @image = nil
        end
      end
    end
  end

end
