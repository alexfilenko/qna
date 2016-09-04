require 'rails_helper'

feature 'Question stories', %q{
  In order to working with questions
  As an authenticated user
  I want to be able working with questions
} do

    given(:user) { create(:user) }

  
  scenario 'Authenticated user creates question' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Non-authenticated user tries to create question' do
    visit questions_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

    scenario 'Authenticated user delete question' do
    sign_in(user)
    visit question_path
    click_on 'Delete'
    expect(page).to have_content 'Your question successfully deleted'
  end

    scenario 'User see all questions' do
    visit questions_path
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content answer.body
    expect(page).to have_content(questions[0].title)
    expect(page).to have_content(questions[1].title)
  end
end