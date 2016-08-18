require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to ask question
  As an user
  I want to be able to sign in
} do

  scenario 'Registred user try to sign in' do
    User.create!(email: 'user@test.com', password: '12345678')

    visit new_user_session_path #visit '/sign_in'
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    clik_on 'Sign in'

    expect(page).to have_content 'Signed in successfuly.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registred user try to sign in' do
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    clik_on 'Sign in'

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end
end