require "gosu"
require_relative "../flappyman.rb"
require_relative "collider.rb"
require "pry"

module Flappyman
  class Player < Flappyman::Collider
    attr_accessor :has_jumped

    def initialize
      @image = Gosu::Image.new("#{Flappyman.asset_dir.to_s}/fighter.png")
      @x = @y = @vel_x = @vel_y = @angle = 0.0
      @has_jumped = false
    end

    def warp(x, y)
      @x, @y = x, y
    end

    def accelerate_down
      @vel_y = @vel_y - Gosu::offset_y(@angle, 0.8)
    end

    def jump
      @vel_y = -10.0
    end

    def die
      Window.game_state = EventStates::DEAD_GAME_STATE
    end

    def move
      @x += @vel_x
      @y += @vel_y
      @x %= 640
      @y %= 480

      @vel_y *= 0.95
      @vel_x *= 0.95
    end

    def draw
      @image.draw_rot(@x, @y, 1, @angle)
    end
  end
end
