require 'yandex-direct/version'
require 'yandex-direct/api'
require 'yandex-direct/base'
require 'yandex-direct/banner_info'
require 'yandex-direct/banner_info_wrapper'
require 'yandex-direct/campaign_info'
require 'yandex-direct/campaign_info_wrapper'

module YandexDirect
  class RuntimeError < RuntimeError ; end
  class NotFound < RuntimeError ; end
end
