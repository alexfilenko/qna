require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user) { create :user }
  let(:question) { create :question }
  let(:answer) { create :answer, question: question }
  let(:user_answer) { create :answer, question: question, user: user }


  describe 'GET #new' do
    sign_in_user

    before { get :new, question_id: question }

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves the new answer in th database' do
        expect do
          post :create,
               question_id: question,
               answer: attributes_for(:answer)
        end.to change { question.answers.count }.by(1)
      end

      it 'redirect to question show view' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect do
          post :create,
               question_id: question,
               answer: attributes_for(:invalid_answer)
        end.to_not change(Answer, :count)
      end

      it 're-render new view' do
        post :create,
             question_id: question,
             answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, id: user_answer,
                       question_id: question,
                       answer: { body: 'new body' }
        user_answer.reload
        expect(user_answer.body).to eq 'new body'
      end

      it 'redirects to the question' do
        patch :update, id: user_answer,
                       question_id: question,
                       answer: { body: 'new body' }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      before do
        patch :update,
              id: answer,
              question_id: question,
              answer: { body: nil }
      end

      it 'does not change answer attributes' do
        answer.reload
        expect(answer.body).to eq 'MyText'
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:answer) { create(:answer, user: @user, question: question) }
    it 'delete answer' do
      expect { delete :destroy, question_id: question, id: answer }.to change(Answer, :count).by(-1)
    end

    it 'redirects to question' do
      delete :destroy, id: user_answer, question_id: question
      expect(response).to redirect_to question
    end
  end
end