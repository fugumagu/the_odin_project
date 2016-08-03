APP_ROOT = File.dirname(__FILE__)
$:.unshift(File.join(APP_ROOT, 'lib'))

require 'tic_tac_toe'

game = Game.new
game.launch!