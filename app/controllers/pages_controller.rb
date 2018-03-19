class PagesController < ApplicationController
  before_action :require_login, only: :home

  def home
    @transaction = Transaction.new
    @transactions = current_user.last_transactions
  end

  private

  def require_login
    render :welcome if current_user.blank?
  end
end
