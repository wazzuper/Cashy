require 'rails_helper'

feature 'Main Page Visitation' do
  scenario 'allows a guest to visit a main page' do
    visit(welcome_path)

    expect(page).to have_content('Hello world')
  end
end
