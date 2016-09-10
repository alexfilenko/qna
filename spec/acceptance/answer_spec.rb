require 'rails_helper'


feature 'Answer stories', %q{
  Create, Delete, View
} do

    given!(:user) { create(:user) }
    given!(:question) { create(:question) }
    given(:answer) { create(:answer, question: question) }
    given(:user_answer) { create(:answer, question: question, user: user) }


  scenario 'Authenticated user creates answer' do
    sign_in(user)
    click_on 'Add answer'
    visit questions_path(question)
    fill_in 'Body', with: 'text text'
    click_on 'Add answer'
    expect(page).to have_content 'Your answer successfully created.'
    expect(page).to have_content('text text')
    expect(current_path).to eq question_path(question)
  end

    scenario 'Non-authenticated user create answer' do
    visit question_path question
    expect(page).to_not have_content 'Add answer'

    visit new_question_answer_path question
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

    scenario 'Aut user delete answer' do
    user_answer

    sign_in(user)
    visit question_path question
    find('.table').click_on 'Delete'
    expect(page).to have_content 'Your answer successfully deleted'
  end

  scenario "No aut delete over answer" do
    visit question_path(question)

    expect(page).to_not have_content('Delete answer')
    expect(current_path).to eq question_path(question)
  end

    scenario 'View question and answers list' do
    visit question_path(question)

    expect(page).to have_content(question.title)
    expect(page).to have_content(question.body)
    expect(page).to have_content(question.answers[0].body)
    expect(page).to have_content(question.answers[1].body)
  end
end