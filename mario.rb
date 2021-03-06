class Mario < Chingu::GameObject
  def button_down?(*args)
    $window.button_down?(*args)
  end

  def initialize options={}
    @jump = Gosu::Sample.new("jump.wav")
    super(options.merge(image: Gosu::Image["./images/marioD02.gif"]))
    @x = 200
    @y = 200
  end

  [nil,"d","u"].each do |ud|
    [nil,"r","l"].each do |rl|
      next if ud == rl
      var = "#{ud}#{rl}".to_sym
      ivar = "@#{var.to_s}".to_sym
      define_method var do
        if set_ivar = instance_variable_get(ivar)
          set_ivar
        else
          instance_variable_set(ivar, Chingu::Animation.new(frames:
            [Gosu::Image.new($window, "./images/mario#{ud ? ud.upcase : ""}#{rl ? rl.upcase : ""}02.gif"),
            Gosu::Image.new($window, "./images/mario#{ud ? ud.upcase : ""}#{rl ? rl.upcase : ""}03.gif"),
            Gosu::Image.new($window, "./images/mario#{ud ? ud.upcase : ""}#{rl ? rl.upcase : ""}01.gif")])
          )
        end
      end
    end
  end

  def jump
    unless @jumping
      @jump.play
      @jumping = true
      @old_image = @image
      @y -= @old_image.height
      if item = Item.presence(@x,@y-@old_image.height)
        item.jump
      end
      direction = {left: "L", right: "R", up: "U", down: ""}[@direction]
      frames = (1..14).map do |index|
        index = "0#{index}" if index.to_s.length == 1
        Gosu::Image.new($window, "./images/mariojump#{direction}#{index}.gif")
      end
      @animation = Chingu::Animation.new(frames: frames, loop: false, delay: 25)
    end
  end

  def punch
    unless @punching
      @jump.play
      @punching = true
      @old_image = @image
      frames = (1..4).map do |index|
        Gosu::Image.new($window, "./images/mariopunch2-0#{index}.gif")
      end
      # frames |= (1..3).map do |index|
        # Gosu::Image.new($window, "./images/mariojump#{direction}#{index}.gif")
      # end
      @animation = Chingu::Animation.new(frames: frames, loop: false, delay: 25)
    end
  end

  def draw
    if @animation
      unless @animation.last_frame?
        @image = @animation.next
      else
        @animation = nil
        @image = @old_image
        if @jumping
          @y += @old_image.height
          @jumping = false
        elsif @punching
          @punching = false
        end
        halt
      end
    end
    super
  end

  def move_left
    @x -= 2
    unless button_down?(Gosu::KbUp)
      @image = l.next
    end
    @direction = :left
  end

  def move_right
    @x += 2
    unless button_down?(Gosu::KbDown) || button_down?(Gosu::KbUp)
      @image = r.next
    end
    @direction = :right
  end

  def move_up
    @y -= 2
    if button_down?(Gosu::KbLeft)
      @image = ul.next
    elsif button_down?(Gosu::KbRight)
      @image = ur.next
    else
      @image = u.next
    end
    @direction = :up
  end

  def move_down
    @y += 2
    if button_down?(Gosu::KbLeft)
      @image = dl.next
    elsif button_down?(Gosu::KbRight)
      @image = dr.next
    else
      @image = d.next
    end
    @direction = :down
  end

  def halt
    [nil,"d","u"].each do |ud|
      [nil,"r","l"].each do |rl|
        next if ud == rl
        animation = self.send("#{ud}#{rl}".to_sym)
        if animation.frames.include? @image
          @image = animation.next while @image != animation.frames.first
        end
      end
    end
  end

  def spawn_item
    Item.create({location: [@x,@y]})
  end

end
