ROOT_PATH = File.dirname(File.expand_path(__FILE__))
require 'chingu'
require './mario'
class Game < Chingu::Window
  attr_accessor :name
  def initialize
    super
    @bg = Background.create
    @mario = Mario.create
    @items = []

    puts "enter name"
    @name = gets

    @mario.input = {holding_left: :move_left,
                    holding_right: :move_right,
                    holding_up: :move_up,
                    holding_down: :move_down,
                    released_left: :halt,
                    released_right: :halt,
                    released_up: :halt,
                    released_down: :halt,
                    space: :jump,
                    f: :spawn_item}
  end

  def update

    if @mario.x >= self.width
      @bg.x -= 10
      @mario.x -= 5
      @items.each { |item| item.x -= 10 }
    end

    if @mario.x <= 0
      @bg.x += 10
      @mario.x += 5
      @items.each { |item| item.x += 10 }
    end

    if @mario.y >= self.height
      @bg.y -= 10
      @mario.y -= 5

      @items.each { |item| item.y -= 10 }
    end

    if @mario.y <= 0
      @bg.y += 10
      @mario.y += 5
      @items.each { |item| item.y += 10 }
    end

    super
  end

  def item_add item
    @items << item
  end

  def item_presence itemx,itemy
    @found = nil
    item = []
    item << (itemx-25..itemx+25).to_a.find do |testx|
      @found = @items.find do |item|
        item.x == testx
      end
    end

    item << (itemy-25..itemy+25).to_a.find do |testy|
      @found = @items.find do |item|
        item.y == testy
      end
    end

    if item.first && item.last
      puts @found.url
      @found
    else
      nil
    end
  end

end

class Item < Chingu::GameObject
  attr_accessor :creator, :url
  def initialize options
    location = options[:location]
    creator = options[:creator]
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

class Background < Chingu::GameObject
  def initialize options={}
    super(options.merge(image: Gosu::Image["./images/light_world.png"]))
    @x = 0
    @y = 0
  end
end

Game.new.show
