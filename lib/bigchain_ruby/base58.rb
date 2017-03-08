module BigchainRuby
  class Base58
    CHARS = %w(
      123456789
      ABCDEFGHJKLMNPQRSTUVWXYZ
      abcdefghijkmnopqrstuvwxyz
    )

    def self.decoding_table
      @decoding_table ||= CHARS.join.split('')
        .each_with_index
        .each_with_object({}) do |(c, i), store|
        store[c] = i
      end
    end

    def self.encoding_table
      @encoding_table ||= decoding_table.invert
    end

    def self.encode(data)
      cdata = data.unpack('C*')
      vlong = cdata.inject(0) { |store, v| store = v + store * 256; store }
      result = ""
      while vlong > 0 do
        result += encoding_table[vlong % 58]
        vlong /= 58
      end
      while cdata.first == 0 do
        result += '1'
        cdata = cdata[1..-1]
      end
      result.reverse
    end

    def self.decode(data_string)
      vlong = data_string.each_byte.inject(0) do |store, b|
        store = decoding_table[b.chr] + (58 * store)
        store
      end
      result = ""
      while vlong > 0 do
        result += (vlong % 256).chr
        vlong /= 256
      end
      while data_string[0] == '1' do
        result += "\x00"
        data_string = data_string[1..-1]
      end
      result.reverse
    end
  end
end
