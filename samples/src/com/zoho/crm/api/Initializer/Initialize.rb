require 'ZOHOCRMSDK2_0'
class Initialize
  def self.Initialize
    log = ZOHOCRMSDK::SDKLog::Log.initialize(level: ZOHOCRMSDK::Levels::INFO, path:"/Users/user_name/Documents/rubysdk_log.log")
    tokenstore = ZOHOCRMSDK::Store::FileStore.new('/Users/user_name/RUBYWS/zohocrm-rubysdk-sample-application/tokens.txt')
    token =  ZOHOCRMSDK::Authenticator::OAuthToken.new(client_id: "clientId", client_secret:"clientSecret", grant_token:"grant_token", refresh_token:"refresh_token", redirect_url:"redirectURL")
    user = ZOHOCRMSDK::UserSignature.new('abc@zohocorp.com')
    environment = ZOHOCRMSDK::DC::USDataCenter::PRODUCTION
    sdk_config = ZOHOCRMSDK::SDKConfig.new(auto_refresh_fields: true,pick_list_validation: true,open_timeout: 60,read_timeout: 60,write_timeout: 60,keep_alive_timeout: 2)
    resource_path = '/Users/user_name/RUBYWS'
    ZOHOCRMSDK::Initializer.initialize(user: user, environment: environment, token: token, store: tokenstore, sdk_config: sdk_config, resources_path: resource_path, log: log)
  rescue StandardError => ex
    print ex.inspect
  end
end
