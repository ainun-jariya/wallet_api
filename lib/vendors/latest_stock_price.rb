# frozen_string_literal: true

# API from https://rapidapi.com/suneetk92/api/latest-stock-price
module LatestStockPrice
  # class Error < StandardError; end
  class Stock
    require 'uri'
    require 'net/http'
    const PATH = URI('https://latest-stock-price.p.rapidapi.com')
    const HOST = URI('latest-stock-price.p.rapidapi.com')
    const KEY = URI('5c71ef6d6cmsh391803262a8d3bbp1c6f46jsn523da54a319c')

    def index
      http_request(URI("#{PATH}/any"))
    end

    def search(args)
      url = URI("#{PATH}/price")
      params = {}
      params[:Indices] = args[:Indices] # if args[:Indices].present? . It's required
      params[:Identifier] = args[:Identifier] if args[:Identifier].present?
      url.query = URI.encode_www_form(params)
      http_request(url)
    end

    def indices
      [
        'NIFTY 50', 'NIFTY NEXT 50', 'NIFTY 100', 'NIFTY 200', 'NIFTY 500', 'NIFTY MIDCAP 50',
        'NIFTY MIDCAP 100', 'NIFTY MIDCAP 150', 'NIFTY SMLCAP 50', 'NIFTY SMLCAP 100', 'NIFTY SMLCAP 250',
        'NIFTY MIDSML 400', 'NIFTY BANK', 'NIFTY AUTO'
      ]
    end

    private

    def http_request(url: URI("#{PATH}/"))
      HttpRequest.get_all(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(url)
      request['X-RapidAPI-Key'] = self.KEY
      request['X-RapidAPI-Host'] = self.HOST
      response = http.request(request)
      puts response.read_body
      response.read_body
    end
  end
end
