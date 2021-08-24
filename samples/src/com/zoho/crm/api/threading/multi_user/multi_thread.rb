require 'ZOHOCRMSDK2_0'
module MultiUser
  class MultiThreading
    def initialize(module_api_name)
      @module_api_name = module_api_name
    end

    def execute
      log = ZOHOCRMSDK::SDKLog::Log.initialize(level: ZOHOCRMSDK::Levels::INFO, path:"/Users/user_name/Documents/rubysdk_log.log")
      user = ZOHOCRMSDK::UserSignature.new('abc@zoho.com')
      environment = ZOHOCRMSDK::DC::USDataCenter::PRODUCTION
      token = ZOHOCRMSDK::Authenticator::OAuthToken.new(client_id: "clientId", client_secret:"clientSecret", grant_token:"grant_token", refresh_token:"refresh_token", redirect_url:"redirectURL")
      tokenstore = ZOHOCRMSDK::Store::FileStore.new('/Users/user_name/RUBYWS/zohocrm-rubysdk-sample-application/tokens.txt')
      sdk_config = ZOHOCRMSDK::SDKConfig.new(auto_refresh_fields: true,pick_list_validation: true,open_timeout: 60,read_timeout: 60,write_timeout: 60,keep_alive_timeout: 2)
      proxy = ZOHOCRMSDK::RequestProxy.new(host:'proxyHost', port:'proxyPort', user_name:'proxyUser', password:'password')
      module_api_name = 'Leads'
      resource_path = '/Users/user_name/RUBYWS'
      ZOHOCRMSDK::Initializer.initialize(user: user, environment: environment, token: token, store: tokenstore, sdk_config: sdk_config, resources_path: resource_path, log: log)
      t1 = Thread.new{ func1 }
      t2 = Thread.new{ func1 }
      t1.join
      t2.join
    end

    def func1
      ro = ZOHOCRMSDK::Record::RecordOperations.new
      ro.get_records(@module_api_name,nil,nil)
    end
  end
end

