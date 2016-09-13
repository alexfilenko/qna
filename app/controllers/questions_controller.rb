class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :load_question, only: [:edit, :update, :destroy]
  
  def index
    @questions = Question.all
  end
  
  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
  end
  
  def new
    @question = current_user.questions.new
  end
  
  def edit
    if @question.nil?
    flash[:danger] = "You can not edit this question"
    redirect_to questions_path
    end
  end
  
  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      flash[:success] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end
  
  def update
    if current_user.author_of?(@question)
      if @question.update(question_params)
        flash[:success] = "Your question has been updated successfully."
        redirect_to @question
      else
        flash[:error] = @question.errors.full_messages
        render :edit
      end
    else
      flash[:error] = "You cannot edit questions written by others."
      redirect_to @question
    end
  end
  
  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      flash[:success] = "Your question has been successfully deleted!"
    else
      flash[:error] = "You cannot delete questions written by others."
    end
    redirect_to questions_path
  end
  
  private
  
  def load_question
    @question = Question.find(params[:id])
  end
  
  def question_params
    params.require(:question).permit(:title, :body)
  end
end