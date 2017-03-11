class BigchainRuby::Pool
  attr_reader :connections, :picker_class
  private :connections, :picker_class

  def initialize(connections, picker_class = BigchainRuby::RoundRobinPicker)
    @connections = connections
    @picker_class = picker_class
  end

  def get_connection
    if connections.length > 1
      picker.pick
    else
      connections.first
    end
  end

  private

  def picker
    @picker ||= picker_class.new(connections)
  end
end
