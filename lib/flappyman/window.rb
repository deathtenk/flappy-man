require 'gosu'
require_relative 'player.rb'
require_relative 'pipe.rb'
require_relative 'utils/collision.rb'
require_relative 'double_pipe.rb'
require_relative 'utils/event_states.rb'
require_relative '../flappyman.rb'

module Flappyman
  class  Window < Gosu::Window
    
    extend EventStates

    @@game_state = nil
    @@score = nil

    def self.game_state
      @@game_state
    end

    def self.score
      @@score
    end

    def self.score+=(points)
      @@score += points
    end

    def self.game_state=(game_state)
      @@game_state = game_state
    end

    def initialize
      super(640, 480)
      self.caption = 'flappyman!'
      @@game_state = EventStates::NEW_GAME_STATE


      @player = Flappyman::Player.new
      @player.warp(320, 240)
      @pipes = []
      @timer = 0
    end

    def update
      case @@game_state
      when EventStates::NEW_GAME_STATE
        run_game
      else
        end_game
      end
    end

    def end_game
      puts "game over"
      puts "would you like to try again? y or n"
      try = $stdin.gets.chomp
      if try =~ /y/
        Flappyman.restart
      else
        Flappyman.quit(self)
      end
    end

    def run_game
      if Gosu::button_down? Gosu::KbSpace and !@player.has_jumped
        @player.jump
        @player.has_jumped = true
      end
      @player.has_jumped = false if !Gosu::button_down? Gosu::KbSpace and @player.has_jumped
      @player.accelerate_down
      @player.move

      # spawn pipes
      if @timer > (60 * 1.0)
        double_pipes = Flappyman::DoublePipe.new
        double_pipes.warp(640,[*180..280].sample)
        @pipes << double_pipes
        @timer = 0
      end

      # pipe movement
      @pipes.each { |pipe| pipe.move }

      # collision
      @pipes.each {|pipe| @player.die if Flappyman::Utils::Collision.call(@player,pipe.pipe_1) ||
                                         Flappyman::Utils::Collision.call(@player,pipe.pipe_2) }

      # cleanup
      @pipes.delete_if { |pipe| pipe.x < -30 }
      @timer += 1
    end

    def draw
      @player.draw
      @pipes.each { |pipe| pipe.draw }
    end

    private
    attr_writer :game_state
  end
end
