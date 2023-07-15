# frozen_string_literal: true

require './app/models/user_accounts_email_tokens'
require 'sinatra/activerecord'

# one day
MAX_AGE = 24 * 60 * 60

## UserAccountsRepository
class UserAccountsEmailTokensRepository < ActiveRecord::Base
  validates_presence_of :user_id, :valid_for
  self.table_name = 'user_accounts_email_tokens'
  # def self.new_email_token(user)
  #   valid_for = Time.now + MAX_AGE
  #   email = UserAccountsEmailTokens.new
  #   email.user_id = user.id
  #   email.creted_at = Time.now
  #   email.valid_for = valid_for

  #   email.save

  #   email
  # end

  # def self.user_id_from_code(code)
  #   email = UserAccountsEmailTokens.find_by(id: code)

  #   email.user_id
  # end

  # def self.token_from_user(user)
  #   email = UserAccountsEmailTokens.find_by(user_id: user.id)

  #   return nil unless email

  #   email
  # end

  # def self.email_tokem_from_code(code)
  #   UserAccountsEmailTokens.find_by(id: code)
  # end

  # def self.destroy_code(user)
  #   UserAccountsEmailTokens.where(user_id: user.id).delete_all
  # end
end
