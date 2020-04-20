require 'rails_helper'

RSpec.describe User, type: :model do
  # Validation tests
  it { should validate_presence_of(:tipo_usuario) }
  it { should validate_presence_of(:nombres) }
  it { should validate_presence_of(:apellidos) }
  it { should validate_presence_of(:direccion) }
  it { should validate_presence_of(:distrito) }
  it { should validate_presence_of(:tipo_documento) }
  it { should validate_presence_of(:numero_documento) }
  it { should validate_presence_of(:fecha_nacimiento) }
  # it { should validate_presence_of(:fecha_inicio) } no es obligatorio
  it { should validate_presence_of(:talla) }
  it { should validate_presence_of(:peso) }
  it { should validate_presence_of(:sexo) }
  it { should validate_presence_of(:esta_en_escalada) }
  it { should validate_presence_of(:esta_en_entrenamiento) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
