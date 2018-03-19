require 'rails_helper'

feature 'Main Page Visitation' do
  scenario 'allows a guest to visit a main page' do
    visit(root_path)

    expect(page).to have_content(I18n.t 'main_page_guest.welcome')
  end
end
