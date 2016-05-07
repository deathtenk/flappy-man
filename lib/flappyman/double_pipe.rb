require "gosu"
require_relative "../flappyman.rb"
require_relative "pipe.rb"

module Flappyman
  class DoublePipe
    attr_accessor :base_speed
    attr_reader :x, :y, :x_offset, :y_offset, :pipe_1, :pipe_2

    def initialize
      @x = @y = @vel_x = @vel_y = @angle = 0.0
      @y_offset = 80.0
      @x_offset = 0.0
      @pipe_1 = Flappyman::Pipe.new
      @pipe_2 = Flappyman::Pipe.new
      @base_speed = 2.5
    end

    def warp(x, y)
      @x, @y = x, y
    end

    def move
      @x += -1*@base_speed
      @y += @vel_y
      # @x %= 640
      # @y %= 480

      @vel_y *= 0.95
      @vel_x *= 0.95
    end

    def draw
      # offset from center
      @pipe_1.x = @x + @x_offset
      @pipe_1.y = @y + @y_offset
      @pipe_2.x = @x - @x_offset
      @pipe_2.y = @y - @y_offset

      # angle
      @pipe_1.angle = 0.0
      @pipe_2.angle = 180.0

      # draw
      @pipe_1.draw
      @pipe_2.draw
    end
  end
end
