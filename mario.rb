# require 'chingu'
class Mario < Chingu::GameObject
  def initialize options={}
    super(options.merge(image: Gosu::Image["./images/marioD02.gif"]))
  end

  def move_left
    @x -= 2
    if @down
      @image = Gosu::Image["./images/marioDL02.gif"]
    elsif @up
      @image = Gosu::Image["./images/marioUL02.gif"]
    else
      @image = Gosu::Image["./images/marioL02.gif"]
    end
  end

  def move_right
    @x += 2
    if @down
      @image = Gosu::Image["./images/marioDR02.gif"]
    elsif @up
      @image = Gosu::Image["./images/marioUR02.gif"]
    else
      @image = Gosu::Image["./images/marioR02.gif"]
    end
    @direction = 0
  end

  def halt_left

  end

  def halt_right

  end

  def move_up
    @y -= 2
    @image = Gosu::Image["./images/marioU02.gif"]
    @up = true
  end

  def move_down
    @y += 2
    @image = Gosu::Image["./images/marioD02.gif"]
    @down = true
  end

  def halt_up
    @up = false
  end

  def halt_down
    @down = false
  end
end
