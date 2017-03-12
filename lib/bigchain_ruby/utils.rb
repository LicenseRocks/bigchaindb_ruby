require 'pry'
require 'addressable'

class BigchainRuby::Utils
  DEFAULT_NODE = 'http://localhost:9984'

  OPTS_MAP = {'CREATE' => BigchainRuby::CreateOperation, 'TRANSFER' => BigchainRuby::TransferOperation}

  def get_default_port(schema)
    schema == 'https' ? 443 : 9984
  end

  def normalize_nodes(*nodes)
    return [DEFAULT_NODE] if nodes.empty?

    nodes.map do |node|
      if node
        uri = Addressable::URI.parse(node)
        unless uri.host
          uri = Addressable::URI.parse("http://#{node}")
        end
        uri.port ||= get_default_port(uri.scheme)
        uri.to_s
      else
        DEFAULT_NODE
      end
    end
  end

  private

  def normalize_operation(operation)
    operation_to_uppercase(operation) || operation_instantiate(operation)
  end

  def operation_to_uppercase(operation)
    operation.upcase
  rescue NoMethodError
    nil
  end

  def operation_instantiate(operation)
    OPTS_MAP.fetch(operation).new
  rescue KeyError
    nil
  end
end
