require_relative 'token_store'
require_relative '../oauth_token'
require_relative '../../../crm/api/util/constants'

module ZOHOCRMSDK
  module Store
    class OAuthToken < ::ActiveRecord::Base
      self.table_name = 'zoho_auth_tokens'
      attr_accessor :client_id, :client_secret

      after_initialize do
        self.client_id = ENV['ZOHO_CLIENT_ID']
        self.client_secret = ENV['ZOHO_CLIENT_SECRET']
      end
    end

    # This class stores the user token details to the MySQL DataBase.
    class DBStore < TokenStore
      attr_reader :user_name, :password, :port_number, :host, :database_name, :table_name

      # Creates an DBStore class instance with the specified parameters.
      # @param host [string] A String containing the DataBase host name.
      # @param database_name A String containing the DataBase name.
      # @param table_name A String containing the table name.
      # @param user_name A String containing the DataBase user name.
      # @param password A String containing the DataBase password.
      # @param port_number A String containing the DataBase port number.
      def initialize(*args )
      end

      def get_token(user, token)
        records = ZOHOCRMSDK::SDK::OAuthToken.where(user_mail: user.email)

        if token.grant_token.nil?
          records.where(refresh_token: token.refresh_token)
        else
          records.where(grant_token: token.grant_token)
        end

        records.first
      end

      def save_token(user, token)
        ZOHOCRMSDK::SDK::OAuthToken.create!(
          external_id: token.id,
          user_mail: user.email,
          refresh_token: token.refresh_token,
          access_token: token.access_token,
          grant_token: token.grant_token,
          expiry_time: token.expires_in,
          redirect_url: token.redirect_url
        )
      end

      def delete_token(token)
        records = ZOHOCRMSDK::SDK::OAuthToken.where(user_mail: token.user_mail)

        if token.grant_token.nil?
          records.where(refresh_token: token.refresh_token)
        else
          records.where(grant_token: token.grant_token)
        end

        records.delete_all
      end

      def delete_tokens
        ZOHOCRMSDK::SDK::OAuthToken.delete_all
      end

      def get_tokens
        ZOHOCRMSDK::SDK::OAuthToken.all
      end

      def get_token_by_id(id,token)
        ZOHOCRMSDK::SDK::OAuthToken.find_by(external_id: id)
      end
    end
  end
end
