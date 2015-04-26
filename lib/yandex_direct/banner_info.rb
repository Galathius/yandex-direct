module YandexDirect
  #
  # = PhraseUserParams
  #
  class PhraseUserParams < Base
    direct_attributes :Param1, :Param2
  end
  #
  # = Phrases
  #
  class BannerPhraseInfo < Base
    direct_attributes :PhraseID, :Phrase, :IsRubric, :Price, :AutoBudgetPriority, :ContextPrice, :AutoBroker
    direct_objects UserParams: PhraseUserParams
  end

  #
  # = Sitelink
  #
  class Sitelink < Base
    direct_attributes :Title, :Href
  end

  #
  # = MapPoint
  #
  class MapPoint < Base
    direct_attributes :x, :y, :x1, :y1, :x2, :y2
  end

  #
  # = ContactInfo
  #
  class ContactInfo < Base
    direct_attributes :CompanyName, :ContactPerson, :Country, :CountryCode, :City, :Street, :House, :Build,
      :Apart, :CityCode, :Phone, :PhoneExt, :IMClient, :IMLogin, :ExtraMessage, :ContactEmail, :WorkTime, :OGRN
    direct_objects PointOnMap: MapPoint
  end

  #
  # = Banner
  #
  class BannerInfo < Base
    direct_attributes :BannerID, :CampaignID, :Title, :Text, :Href, :Geo, :MinusKeywords
    direct_arrays Phrases: BannerPhraseInfo, Sitelinks: Sitelink
    direct_objects ContactInfo: ContactInfo

    attr_reader :api

    def initialize(params, api)
      @api = api
      super(params)
    end

    def save
      api.request('CreateOrUpdateBanners', [self.to_hash]).first
    end

    def archive
      api.request('ArchiveBanners', { CampaignID: self.CampaignID, BannerIDS: [self.BannerID] })
    end

    def unarchive
      api.request('UnArchiveCampaign', { CampaignID: self.CampaignID, BannerIDS: [self.BannerID] })
    end

    def moderate
      api.request('ModerateBanners', { CampaignID: self.CampaignID, BannerIDS: [self.BannerID] })
    end

    def resume
      api.request('ResumeBanners', { CampaignID: self.CampaignID, BannerIDS: [self.BannerID] })
    end

    def stop
      api.request('StopBanners', { CampaignID: self.CampaignID, BannerIDS: [self.BannerID] })
    end

    def delete
      api.request('DeleteBanners', { CampaignID: self.CampaignID, BannerIDS: [self.BannerID] })
    end
  end
end
