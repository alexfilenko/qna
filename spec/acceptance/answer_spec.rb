require 'rails_helper'


feature 'Answer stories', %q{
  In order to working with answers
  As an authenticated user
  I want to be able working with answers
} do

  let(:user) { create(:user) }
  let(:question) { create(:question) }


  scenario 'User create answer' do
    sign_in(user)
    visit questions_path(question)
    fill_in 'Body', with: 'text text'
    click_on 'Create'

    expect(page).to have_content 'Your answer successfully created.'
    expect(page).to have_content('Some answer body')
    expect(current_path).to eq question_path(question)
  end
end