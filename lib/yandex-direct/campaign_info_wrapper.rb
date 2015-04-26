module YandexDirect
  class CampaignInfoWrapper
    attr_reader :api

    def initialize(api)
      @api = api
    end

    def find(id)
      campaign = api.request('GetCampaignParams', { CampaignID: id })
      raise YandexDirect::NotFound.new("not found campaign where CampaignID = #{id}") if campaign.empty?
      CampaignInfo.new(campaign, api)
    end

    def list
      api.request('GetCampaignsList').map do |campaign|
        CampaignInfo.new(campaign, api)
      end
    end
  end
end
