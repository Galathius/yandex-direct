module YandexDirect
  class CampaignStrategy < Base
    direct_attributes :StrategyName, :MaxPrice, :AveragePrice, :WeeklySumLimit, :ClicksPerWeek
  end

  class SmsNotification < Base
    direct_attributes :MetricaSms, :ModerateResultSms, :MoneyInSms, :MoneyOutSms, :SmsTimeFrom, :SmsTimeTo
  end

  class EmailNotification < Base
    direct_attributes :Email, :WarnPlaceInterval, :MoneyWarningValue, :SendAccNews, :SendWarn
  end

  class TimeTarget < Base
    direct_attributes :ShowOnHolidays, :HolidayShowFrom, :HolidayShowTo, :DaysHours, :TimeZone
  end

  class TimeTargetItem < Base
    direct_attributes :Days, :Hours
  end

  class CampaignInfo < Base
    direct_attributes :Login, :CampaignID, :Name, :FIO, :StartDate, :StatusBehavior, :StatusContextStop,
      :ContextLimit, :ContextLimitSum, :ContextPricePercent,:AutoOptimization, :StatusMetricaControl, :DisabledDomains,
      :DisabledIps, :StatusOpenStat, :ConsiderTimeTarget, :MinusKeywords, :AddRelevantPhrases,
      :RelevantPhrasesBudgetLimit, :Sum, :Rest, :SumAvailableForTransfer, :Shows, :Clicks, :Status, :StatusShow,
      :StatusArchive, :StatusActivating, :StatusModerate, :IsActive, :ManagerName, :AgencyName
    direct_objects Strategy: CampaignStrategy,
      SmsNotification: SmsNotification,
      EmailNotification: EmailNotification,
      TimeTarget: TimeTarget

    attr_reader :api

    def initialize(params, api)
      @api = api
      super(params)
    end

    def banners
      api.request('GetBanners', { CampaignIDS: [self.CampaignID]} ).map do |banner|
        BannerInfo.new(banner, api)
      end
    end

    def save
      api.request('CreateOrUpdateCampaign', self.to_hash)
    end

    def archive
      api.request('ArchiveCampaign', { CampaignID: self.CampaignID })
    end

    def unarchive
      api.request('UnArchiveCampaign', { CampaignID: self.CampaignID })
    end

    def resume
      api.request('ResumeCampaign', { CampaignID: self.CampaignID })
    end

    def stop
      api.request('StopCampaign', { CampaignID: self.CampaignID })
    end

    def delete
      api.request('DeleteCampaign', { CampaignID: self.CampaignID })
    end
  end
end
