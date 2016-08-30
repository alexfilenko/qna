class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  
  def index
    @questions = Question.all
  end
  
  def show
    @question = Question.find(params[:id])
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
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end
  
  def update
    if @question.update(question_params)
      flash[:success] = "Your question successfully changed"
      redirect_to @question
    else
      render :edit
    end
  end
  
  def destroy
    if @question.nil?
      flash[:danger] = "You can not delete this question"
      redirect_to questions_path
    else
      current_user.questions.destroy(@question)
      flash[:notice] = 'You are not the author'
      redirect_to questions_path
    end
  end
  
  private
  
  def load_question
    @question = current_user.questions.find_by(id: params[:id])
  end
  
  def question_params
    params.require(:question).permit(:title, :body)
  end
end