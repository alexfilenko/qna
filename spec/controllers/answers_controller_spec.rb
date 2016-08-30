require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create :user }
  let(:question) { create :question }
  let(:answer) { create :answer, question: question }
  let(:user_answer) { create :answer, question: question, user: user }

  describe 'GET #new' do
    sign_in_user
    before {get :new, question_id: question }
    
      it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
    
    it 'renders new view' do
    expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before do
      log_in user
      get :edit, id: user_answer, question_id: question
    end

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to eq user_answer
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do

      it 'saves the new answer in the database'do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question path' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do

      it 'does not save the answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) } }.to_not change(Answer, :count)
      end

      it 're-renders new view'do
        post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before do
      log_in user
    end

  context 'with valid attributes' do
    it 'changes answer attributes' do
      patch :update, params: {id: user_answer, question_id: question, answer: { body: 'text text' } }                
      user_answer.reload
      expect(user_answer.body).to eq 'new body'
    end

  it 'redirects to the question' do
      patch :update, params: {id: user_answer, question_id: question, answer: { body: 'new body' } } 
      expect(response).to redirect_to question
    end
  end

  context 'with invalid attributes' do
      before do
        patch :update, params: {id: answer, question_id: question, answer: { body: nil } }        
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
    before do
      log_in user
      user_answer
    end

    it 'deletes answer' do
      expect { delete :destroy, id: user_answer, question_id: question }
        .to change(Answer, :count).by(-1)
    end

      it 'redirects to question' do
        delete :destroy, id: user_answer, question_id: question
        expect(response).to redirect_to question
      end
    end
  end