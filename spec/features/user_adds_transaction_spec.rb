require 'rails_helper'

feature 'Home page visitation' do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  scenario 'allows a user to create a transaction' do
    fill_in('Amount', with: 555)
    fill_in('Date', with: '15/3/2018')
    click_button(I18n.t 'main_page_user.form_add')

    expect(page).to have_content(I18n.t 'transaction.added')
    expect(page).to have_content(555)
    expect(page).to have_content('15/03/2018')
  end

  scenario 'outputs an error message for user because of empty amount value' do
    click_button(I18n.t 'main_page_user.form_add')

    expect(page).to have_content('Amount can\'t be blank')
  end

  scenario 'outputs an error message for user because he type a string' do
    fill_in('Amount', with: '+-eee')
    click_button(I18n.t 'main_page_user.form_add')

    expect(page).to have_content('Amount is not a number')
  end

  scenario 'outputs an error message for user because he choose date in the future' do
    fill_in('Date', with: '15/3/2222')
    click_button(I18n.t 'main_page_user.form_add')

    expect(page).to have_content(I18n.t ('feature_tests.date.in_the_future'))
  end
end
