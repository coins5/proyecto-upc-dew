class UserExamsController < ApplicationController
  before_action :set_user
  before_action :set_user_exam, only: [:show, :update, :destroy]

  # GET /users/:user_id/user_exams
  def index
    json_response(@user.user_exams)
  end

  # GET /users/:user_id/user_exams/:id
  def show
    json_response(@user_exam)
  end

  # POST /users/:user_id/user_exams
  def create
    @user.user_exams.create!(user_exam_params)
    json_response(@user, :created)
  end

  # PUT /users/:user_id/user_exams/:id
  def update
    @user_exam.update(user_exam_params)
    head :no_content
  end

  # DELETE /users/:user_id/user_exams/:id
  def destroy
    @user_exam.destroy
    head :no_content
  end

  private

  def user_exam_params
    params.permit(:fecha, :puntaje, :user_id, :exam_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_exam
    @user_exam = @user.user_exams.find_by!(id: params[:id]) if @user
  end
end