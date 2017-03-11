require 'pry'
class BigchainRuby::Transport
  attr_reader :pool, :node_urls, :headers
  private :pool, :node_urls, :headers

  def initialize(*node_urls, headers: {})
    @node_urls = node_urls
    @headers = headers
  end

  def forward_request(method, path, json: {}, headers: {})
    response = connection.request(method, path, json: json, headers: headers)
    response.data
  end

  private

  def connection
    pool.get_connection
  end

  def pool
    @pool ||= BigchainRuby::Pool.new(connections)
  end

  def connections
    node_urls.map do |node_url|
      BigchainRuby::Connection.new(node_url, headers: headers)
    end
  end
end
