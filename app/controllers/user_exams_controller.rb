=begin
class UserExamsController < ApplicationController
  before_action :set_user_exam, only: [:show, :update, :destroy]

  # GET /user_exams
  def index
    @user_exams = User_Exam.all
    json_response(@user_exams)
  end

  # POST /user_exams
  def create
    @user_exam = User_Exam.create!(user_exam_params)
    json_response(@user_exam, :created)
  end

  # GET /user_exams/:id
  def show
    json_response(@user_exam)
  end

  # PUT /user_exams/:id
  def update
    @user_exam.update(user_exam_params)
    head :no_content
  end

  # DELETE /user_exams/:id
  def destroy
    @user_exam.destroy
    head :no_content
  end

  private

  def user_exam_params
    # whitelist params
    params.permit(:fecha, :puntaje, :user_id, :exam_id)
  end

  def set_user_exam
    @user_exam = User_Exam.find(params[:id])
  end
end
=end

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
    # @item = @user.items.find_by!(id: params[:id]) if @user
    @user_exam = @user.user_exams.find_by!(id: params[:id]) if @user
  end
end