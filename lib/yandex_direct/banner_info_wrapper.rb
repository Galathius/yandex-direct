module YandexDirect
  class BannerInfoWrapper
    attr_reader :api

    def initialize(api)
      @api = api
    end

    def find(id)
      result = api.request('GetBanners', { BannerIDS: [id] })
      raise YandexDirect::NotFound.new("not found banner where id = #{id}") unless result.any?
      BannerInfo.new(result.first, api)
    end
  end
end
