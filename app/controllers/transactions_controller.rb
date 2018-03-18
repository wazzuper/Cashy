class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transaction = Transaction.new
    @transactions = current_user.last_transactions
  end

  def new
    @transaction = current_user.transactions.new
  end

  def create
    @transaction = current_user.transactions.new(transactions_params)

    if @transaction.save
      flash[:notice] = t('transaction.added')
      redirect_to request.referrer
    else
      flash[:alert] = @transaction.errors.full_messages.join(', ')
      redirect_to request.referrer
    end
  end

  private

  def transactions_params
    params.require(:transaction).permit(:amount, :date, :comment)
  end
end
