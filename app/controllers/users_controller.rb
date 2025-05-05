# app/controllers/users_controller.rb
class UsersController < ApplicationController

  def new
    @user = User.new # Continua igual
  end

  def create
    # Cria uma nova instância de User com os dados permitidos
    @user = User.new(user_params)

    if @user.save
      # Se o usuário for salvo com sucesso
      flash[:success] = "Usuário cadastrado com sucesso" # Adiciona aviso de segurança
      redirect_to root_url # Ou outra URL de sua escolha
    else
      # Se houver erros de validação
      flash.now[:error] = "Erro ao cadastrar usuário. Verifique os campos."
      render 'new', status: :unprocessable_entity # Renderiza novamente o formulário com erros
    end
  end

  private

  # Método para permitir apenas os parâmetros seguros do formulário
  def user_params
    params.require(:user).permit(:email, :password) # Não precisa mais de password_confirmation
  end
end
#se der problema excluir daqui pra baixo

# app/models/user.rb
#require 'digest/sha2'    # Para usar SHA256 (biblioteca padrão)
#require 'securerandom' # Para gerar um salt aleatório (biblioteca padrão)

#class User < ApplicationRecord
  # attr_accessor temporário para receber a senha do formulário
# attr_accessor :password

  # Validações básicas
# validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
# validates :password, presence: true, length: { minimum: 6 }, on: :create # Validar apenas na criação

  # Callback para hashear a senha antes de salvar
# before_save :encrypt_password # Use before_save para cobrir create e update (se permitido)

  # Método para autenticar uma senha fornecida
# def authenticate(password)
    # Hashea a senha fornecida com o salt armazenado e compara
#   self.password_digest == self.class.hash_password(password, self.salt)
# end

# private

  # Método de classe para hashear a senha com um salt
# def self.hash_password(password, salt)
#   Digest::SHA256.hexdigest(password.to_s + salt.to_s) # Garante que são strings
# end

  # Método de classe para gerar um salt aleatório
# def self.generate_salt
#   SecureRandom.hex(16) # String hexadecimal de 32 caracteres
# end

  # Método para criptografar a senha
  #def encrypt_password
  #if password.present?
      # Gera um novo salt APENAS se for um novo registro ou se a senha estiver sendo atualizada
  #self.salt = self.class.generate_salt unless attribute_present?(:salt) && !password_changed? # Gera salt apenas uma vez ou na mudança de senha
  #self.password_digest = self.class.hash_password(password, self.salt)
  #end
    # O campo 'password' (attr_accessor) não é salvo no banco
  # end

  # Helper privado para verificar se a senha (attr_accessor) mudou
# def password_changed?
#   @password.present? # Consideramos que mudou se o attr_accessor :password foi preenchido
# end
#end