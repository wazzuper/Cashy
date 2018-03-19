class TransactionPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  private

  def transaction
    record
  end
end
