ROOT_PATH = File.dirname(File.expand_path(__FILE__))
require 'chingu'
require './mario'
require './item'
class Game < Chingu::Window
  attr_accessor :name
  def initialize
    super
    @bg = Background.create
    @mario = Mario.create

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
      Item.all.each { |item| item.x -= 10 }
    end

    if @mario.x <= 0
      @bg.x += 10
      @mario.x += 5
      Item.all.each { |item| item.x += 10 }
    end

    if @mario.y >= self.height
      @bg.y -= 10
      @mario.y -= 5

      Item.all.each { |item| item.y -= 10 }
    end

    if @mario.y <= 0
      @bg.y += 10
      @mario.y += 5
      Item.all.each { |item| item.y += 10 }
    end

    super
  end

  def item_presence itemx,itemy
    check_range = 20
    @found = nil
    item = []
    item << (itemx-check_range..itemx+check_range).to_a.find do |testx|
      @found = Item.all.find do |item|
        item.x == testx
      end
    end

    item << (itemy-check_range..itemy+check_range).to_a.find do |testy|
      @found = Item.all.find do |item|
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

class Background < Chingu::GameObject
  def initialize options={}
    super(options.merge(image: Gosu::Image["./images/light_world.png"]))
    @x = 0
    @y = 0
  end
end

Game.new.show
