class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    json_response(@users)
  end

  # POST /users
  def create
    # TODO: Enviar correo 
    @user = User.create!(user_params)
    json_response(@user, :created)
  end

  # GET /users/:id
  def show
    json_response(@user)
  end

  # PUT /users/:id
  def update
    @user.update(user_params)
    head :no_content
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    # whitelist params
    params.permit(:tipo_usuario, :nombres, :apellidos, :direccion, :distrito, :tipo_documento, :numero_documento, :fecha_nacimiento, :fecha_inicio, :talla, :peso, :sexo, :esta_en_escalada, :esta_en_entrenamiento, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
