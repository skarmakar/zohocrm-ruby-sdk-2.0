require 'ZOHOCRMSDK2_0'
module MultiUser
  class SingleThreading
    def initialize(module_api_name)
      @module_api_name = module_api_name
    end

    def execute
      log = ZOHOCRMSDK::SDKLog::Log.initialize(level:ZOHOCRMSDK::Levels::INFO, path:'/Users/user_name/Documents/rubysdk_log.log')
      token = ZOHOCRMSDK::Authenticator::OAuthToken.new(client_id: "clientId", client_secret:"clientSecret", grant_token:"grant_token", refresh_token:"refresh_token", redirect_url:"redirectURL")
      user = ZOHOCRMSDK::UserSignature.new('abc@zoho.com')
      environment = ZOHOCRMSDK::DC::USDataCenter::PRODUCTION   
      sdk_config = ZOHOCRMSDK::SDKConfig.new(auto_refresh_fields: true,pick_list_validation: true,open_timeout: 60,read_timeout: 60,write_timeout: 60,keep_alive_timeout: 2)
      func1(user, environment, token, sdk_config)
    end

    def func1(user, environment, token, sdk_config)   
      ZOHOCRMSDK::Initializer.switch_user(user: user, environment:environment, token:token, sdk_config:sdk_config)
      print ZOHOCRMSDK::Initializer.get_initializer.user.email
      # Get instance of RecordOperations Class
      ro = ZOHOCRMSDK::Record::RecordOperations.new
      rersponse = ro.get_records(@module_api_name,nil,nil)
      print "\n\n\n"
      print rersponse.data_object.inspect
    end
  end
end
