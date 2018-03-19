class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @transaction = current_user.transactions.new(transactions_params)
    authorize @transaction

    if @transaction.save
      flash[:notice] = t('transaction.added')
      redirect_to root_path
    else
      flash[:alert] = @transaction.errors.full_messages.join(', ')
      redirect_to root_path
    end
  end

  private

  def transactions_params
    params.require(:transaction).permit(:amount, :date, :comment)
  end
end
