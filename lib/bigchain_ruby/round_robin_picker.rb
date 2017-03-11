class BigchainRuby::RoundRobinPicker
  attr_accessor :connections
  private :connections

  def initialize(connections)
    @connections = connections
  end

  def pick
    round_robin.next
  end

  private

  def round_robin
    @round_robin ||= connections.cycle
  end
end
