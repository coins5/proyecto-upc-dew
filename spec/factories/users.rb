FactoryBot.define do
  factory :user do
    tipo_usuario { "normal" }
    nombres { Faker::Name.first_name }
    apellidos { Faker::Name.last_name }
    direccion { Faker::Address.street_address }
    distrito { Faker::Address.state }
    tipo_documento { 'dni' }
    numero_documento { Faker::Number.number(digits: 10) }
    fecha_nacimiento { DateTime.strptime('2001-02-03', '%Y-%m-%d') }
    fecha_inicio { DateTime.strptime('2001-02-03', '%Y-%m-%d') }
    talla { 175 }
    peso { 65.5 }
    sexo { 'masculino' }
    esta_en_escalada { true }
    esta_en_entrenamiento { true }
    email { Faker::Internet.email }
    password { "123456" }
  end
end