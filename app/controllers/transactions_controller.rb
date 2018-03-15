class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, except: [:new, :create]

  def new
    @transaction = current_user.transactions.new
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)

    if @transaction.save
      flash[:notice] = t('transaction.added')
      redirect_to request.referrer
    else
      flash[:alert] = @transaction.errors.full_messages.join(', ')
      redirect_to request.referrer
    end
  end

  def edit
  end

  def update
    if @transaction.update(transaction_params)
      respond_to do |format|
        format.html { redirect_to activity_page_path, notice: t('transaction.updated') }
      end
    else
      flash[:alert] = @transaction.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  def destroy
    @transaction.delete

    flash[:notice] = t('transaction.deleted')
    redirect_to request.referrer
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :date, :comment)
  end

  def set_transaction
    @transaction ||= Transaction.find(params[:id])
  end
end
