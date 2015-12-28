require 'matrix'

class GameOfLife
  def initialize( grid )
    @grid = grid
    @grid.seed
    @grid.display
  end

  def run( sleep_time: 0.05 )
    loop do
      @grid.run_rules
      @grid.apply_change
      @grid.display
      sleep( sleep_time )
    end
  end
end

class Grid
  def initialize( height:, width: )
    @matrix = Matrix.build( height, width )
  end

  def seed
    @matrix = @matrix.each_with_index do |cell|
      x, y = *cell
      Cell.new( x, y, self )
    end
  end

  def display
    system 'clear'
    @matrix.to_a.each do |row|
      puts row.map { |cell| cell }.join( ' ' )
    end
  end

  def run_rules
    @matrix.each( &:run_rules )
  end

  def apply_change
    @matrix.each( &:apply_change )
  end

  def cell_at(x, y)
    @matrix[x, y]
  end
end

class Cell
  def initialize( x, y, grid )
    @x = x
    @y = y
    @grid = grid
    @alive = [true, false].sample
  end

  def to_s
    @alive ? '#' : ' '
  end

  def run_rules
    dead!  if alive? && alive_neighbors < 2               # Rule 1
    alive! if alive? && [2, 3].include?(alive_neighbors)  # Rule 2
    dead!  if alive? && alive_neighbors > 3               # Rule 3
    alive! if dead?  && alive_neighbors == 3              # Rule 4
  end

  def apply_change
    @alive = @pending_action
  end

  def alive?
    @alive
  end

  private

  def neighbors
    neighbors = []
    positions = [-1, 0, 1]
    positions.each do |position_x|
      positions.each do |position_y|
        neighbor_x = @x + position_x
        neighbor_y = @y + position_y
        next if neighbor_x == @x && neighbor_y == @y # Skip itself
        next if neighbor_x < 0 || neighbor_y < 0 # Exclude out of bounds as Matrix will wrap
        neighbor = @grid.cell_at( neighbor_x, neighbor_y )
        next if neighbor.nil? # Exclude out of bounds
        neighbors << neighbor
      end
    end
    neighbors
  end

  def alive_neighbors
    neighbors.count( &:alive? )
  end

  def dead?
    !alive?
  end

  def alive!
    @pending_action = true
  end

  def dead!
    @pending_action = false
  end
end
