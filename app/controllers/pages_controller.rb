class PagesController < ApplicationController
  def welcome
    @transaction = Transaction.new
  end
end
