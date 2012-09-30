ROOT_PATH = File.dirname(File.expand_path(__FILE__))
require 'chingu'
require './mario'
class Game < Chingu::Window
  def initialize
    super
    @mario = Mario.create
    @mario.input = {holding_left: :move_left,
                    holding_right: :move_right,
                    holding_up: :move_up,
                    holding_down: :move_down,
                    released_left: :halt,
                    released_right: :halt,
                    released_up: :halt,
                    released_down: :halt }
  end
end

Game.new.show
