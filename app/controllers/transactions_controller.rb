class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @transaction = current_user.transactions.new
  end

  def create
    @transaction = current_user.transactions.new(transactions_params)

    if @transaction.save
      redirect_to @transaction
    else
      render 'pages/welcome'
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  private

  def transactions_params
    params.require(:transaction).permit(:amount, :date, :comment)
  end
end
