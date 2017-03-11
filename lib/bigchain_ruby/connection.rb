require 'http'
require 'pry'

class BigchainRuby::Connection
  HttpResponse = Struct.new(:status_code, :headers, :data)

  attr_reader :node_url
  private :node_url

  def initialize(node_url, headers: {})
    @node_url = node_url
    @headers = headers
  end

  def request(method, relative_path, json: {}, headers: {})
    response = HTTP
      .headers(headers)
      .public_send(method, File.join(node_url, relative_path), json: json)

    HttpResponse.new(response.status, response.headers, JSON.parse(response.body))
  end
end
