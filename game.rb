ROOT_PATH = File.dirname(File.expand_path(__FILE__))
require 'chingu'
require './mario'
require './item'
class Game < Chingu::Window
  def initialize
    super
    # @bg = Background.create
    @mario = Mario.create
    @small_font = Gosu::Font.new(self, "/home/andrew/workspace/sevenstars/c.ttf", 500)
    @small_font.draw("GO ! ! ! ! O _ O FOOO",50,50, 1,1,1, Gosu::Color::WHITE)
    puts "huh"

  end

  def update

    if @mario.x >= self.width
      # @bg.x -= 10
      @mario.x -= 5
      Item.all.each { |item| item.x -= 10 }
    end

    if @mario.x <= 0
      # @bg.x += 10
      @mario.x += 5
      Item.all.each { |item| item.x += 10 }
    end

    if @mario.y >= self.height
      @bg.y -= 10
      @mario.y -= 5
      Item.all.each { |item| item.y -= 10 }
    end

    if @mario.y <= 0
      # @bg.y += 10
      @mario.y += 5
      Item.all.each { |item| item.y += 10 }
    end

    super
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
