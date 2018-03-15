class PagesController < ApplicationController
  def welcome
    @transaction = Transaction.new
    @transactions = current_user.transactions.limit(10).order(created_at: :desc) if user_signed_in?
  end

  def activity_page
    @transactions = Transaction.order(created_at: :desc)
  end
end
