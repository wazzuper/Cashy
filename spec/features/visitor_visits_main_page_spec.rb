require 'rails_helper'

feature 'Main Page Visitation' do
  scenario 'allows a guest to visit a main page' do
    visit(root_path)

    expect(page).to have_content('Hello World!')
  end
end
