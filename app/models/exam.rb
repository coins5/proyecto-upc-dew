class Exam < ApplicationRecord
  has_many :user_exams
  has_many :users, through: :user_exams

  validates_presence_of :tipo_examen, :name, :description, :minimo, :promedio, :maximo
end
