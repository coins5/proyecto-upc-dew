class User < ApplicationRecord
  has_secure_password

  has_many :user_exams
  has_many :tutors, through: :user_exams
  
  validates_presence_of :tipo_usuario, :nombres, :apellidos, :direccion, :distrito, :tipo_documento, :numero_documento, :fecha_nacimiento, :fecha_inicio, :talla, :peso, :sexo, :esta_en_escalada, :esta_en_entrenamiento, :email, :password_digest
end
