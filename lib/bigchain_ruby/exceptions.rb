module BigchainRuby::Exceptions
  class BigchaindbException < StandardError; end

  class KeypairNotFoundException < BigchaindbException; end
  class InvalidPrivateKey < BigchaindbException; end
  class InvalidPublicKey < BigchaindbException; end
  class MissingPrivateKeyError < BigchaindbException; end

  class TransportError < BigchaindbException
    attr_reader :status_code, :error, :info

    def initialize(status_code, error = nil, info = nil)
      @status_code, @error, @info = status_code, error, info
    end
  end

  class ConnectionError < TransportError; end
  class BadRequest < TransportError; end
  class NotFoundError < TransportError; end

  HTTP_EXCEPTIONS = {400 => BadRequest, 404 => NotFoundError}
end
