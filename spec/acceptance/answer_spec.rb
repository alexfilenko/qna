require 'rails_helper'


feature 'Answer stories', %q{
  In order to working with answers
  As an authenticated user
  I want to be able working with answers
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given(:answer) { create(:answer, question: question) }
  given(:user_answer) { create(:answer, question: question, user: user) }

  scenario 'User reviews answers' do
    answer

    visit question_path question
    expect(page).to have_content answer.body
  end
end