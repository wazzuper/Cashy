class PagesController < ApplicationController
  def welcome
    @transaction = Transaction.new
    @transactions = current_user.transactions.limit(10).order(created_at: :desc) if user_signed_in?
  end
end
