require 'rails_helper'

feature 'User sign in', %q{
  To ask question
} do

  given(:user) { create(:user) }
  
  scenario 'User sign in' do
  	visit new_user_session_path
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'User logout' do
    sign_in(user)

    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end

    scenario 'User reg' do
    visit root_path
    click_on 'Registration'

    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'user_password_conformation', with: '12345678'

    click_on 'Sign up'

    expect(page).to have_content 'You have signed up successfully.'
  end
end