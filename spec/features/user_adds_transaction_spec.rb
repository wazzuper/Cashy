require 'rails_helper'

feature 'Main Page Visitation' do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  scenario 'allows a user to create a transaction' do
    fill_in('Amount', with: 555)
    find('select#transaction_date_3i').find("option[value='#{15}']").select_option
    find('select#transaction_date_2i').find("option[value='#{3}']").select_option
    find('select#transaction_date_1i').find("option[value='#{2018}']").select_option
    click_button(I18n.t 'main_page_user.form_add')

    expect(page).to have_content(I18n.t 'transaction.added')
    expect(page).to have_content(555)
  end

  scenario 'outputs an error message for user because of empty amount value' do
    click_button(I18n.t 'main_page_user.form_add')

    expect(page).to have_content('Amount can\'t be blank')
  end
end
