class PGN
  ATTRS = %w(event site date round white black result moves).freeze
  attr_accessor(*ATTRS)

  def initialize(filename = nil)
    self.from_pgn(filename) if filename
    self.date ||= '??'
    self.round ||= '1'
  end

  def date=(value)
    if value.is_a?(Time)
      @date = value.strftime('%Y.%m.%d')
    else
      @data = value
    end
  end

  def moves=(game)
    @moves = game.gsub("\n", ' ').split(/\d+\./).collect{|t| t.strip}[1..-1].collect{|t| t.split(' ')}.flatten
    @moves.delete_at(@moves.size-1) if @moves.last =~ /(0\-1)|(1\-0)|(1\/2)|(1\/2\-1\/2)|(\*)/
  end

  def from_pgn(filename)
    data = File.open(filename, 'r').read
    data.gsub!(/\{.*?\}/, '')
    ATTRS.reject{|a| a == "moves"}.each do |attr|
      self.send(attr.to_s + '=', value = data.match(/^\[#{attr.capitalize} ".*"\]\s?$/).to_s.strip[attr.size+3..-3])
    end
    game_index = data.index(/^1\./) #lame hack for now
    raise ArgumentError, "unknown action" if game_index.nil?
    self.moves = data[game_index..-1].strip
  end

end
