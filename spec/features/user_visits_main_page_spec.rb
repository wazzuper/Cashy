require 'rails_helper'

feature 'Main Page Visitation' do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  scenario 'allows a user to visit a main page' do
    expect(page).to have_content(I18n.t 'devise.sessions.signed_in')
  end

  scenario 'allows a user to see form for adding money' do
    expect(page).to have_content(I18n.t 'main_page_user.form_title')
    find_button(I18n.t 'main_page_user.form_add').click
  end

  scenario 'allows a user to see last ten transactions' do
    expect(page).to have_content(I18n.t 'main_page_user.transactions_title')
  end
end
