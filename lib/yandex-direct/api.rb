require 'net/http'
require 'net/https'
require 'json'
require 'yaml'
require 'uri'

module YandexDirect
  class API
    URL_API = 'https://api.direct.yandex.ru/live/v4/json/'
    URL_API_SANDBOX = 'https://api-sandbox.direct.yandex.ru/live/v4/json/'

    attr_reader :configuration, :banner_info, :campaign_info

    def initialize(configuration)
      @configuration = configuration
      @configuration[:sandbox] ||= false
      @banner_info = BannerInfoWrapper.new(self)
      @campaign_info = CampaignInfoWrapper.new(self)
    end

    def parse_json(json)
      begin
        return JSON.parse(json)
      rescue => e
        raise RuntimeError.new "#{e.message} in response"
      end
    end

    def request(method, params = {})
      body = {
        locale: configuration[:locale],
        token: configuration[:token],
        method: method
      }

      if body[:method] == 'GetCampaignsList'
        body.merge!(param: [configuration[:login]])
      else
        body.merge!(param: params)
      end

      url = URI((configuration[:sandbox] ?  URL_API_SANDBOX : URL_API))

      if configuration[:verbose]
        puts "\t\033[32mYandex.Direct:\033[0m #{method}(#{body[:param]})"
      end

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      response = http.post(url.path, JSON.generate(body))

      raise RuntimeError.new("#{response.code} - #{response.message}") unless response.code.to_i == 200

      json = parse_json(response.body)

      if json.has_key?('error_code') and json.has_key?('error_str')
        code = json['error_code'].to_i
        error = json['error_detail'].length > 0 ? json['error_detail'] : json['error_str']
        raise RuntimeError.new "#{code} - #{error}"
      end

      json['data']
    end
  end
end
