class AdAccountsController < ApplicationController
  def index
    @ad_accounts = []
    @ad_accounts.push get_ad_accounts_edge("me")
    businesses = graph.get_connections("me", "businesses")
    businesses.each do |business|
      begin
        @ad_accounts.push get_ad_accounts_edge(business["id"])
      rescue StandardError => ex
        Rails.logger.info ex
      end
    end
    @ad_accounts.flatten!
    @ad_accounts.each { |act| act["id"] ||= "act_#{act['account_id']}" }
    @ad_accounts.uniq! { |act| act["id"] }
  end

  def show
  end

  private

  def get_ad_accounts_edge(fb_id)
    graph.get_connections(fb_id, "adaccounts",
      fields: [:name, :business, :amount_spent, :account_status, :age])
  end
end
