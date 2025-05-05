# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController

  def new
    # Apenas renderiza o formulário de login (app/views/sessions/new.html.erb)
  end

  def create
    # Busca o usuário pelo email (ignora maiúsculas/minúsculas)
    user = User.find_by(email: params[:session][:email].downcase)

    # Verifica se o usuário foi encontrado E se a senha está correta
    if user && user.authenticate(params[:session][:password])
      # Login bem-sucedido
      # Armazena o ID do usuário na sessão para mantê-lo logado
      session[:user_id] = user.id
      # Define uma mensagem de sucesso
      flash[:success] = 'Login realizado com sucesso!'
      # Redireciona para onde for necessário (ex: página inicial, dashboard)
      redirect_to root_path # Altere 'root_path' para sua rota desejada após o login

    else
      # Login falhou
      # Define uma mensagem de erro que será exibida NA MESMA página
      flash.now[:alert] = 'E-mail ou senha inválidos.'
      # Renderiza novamente o formulário de login
      render :new, status: :unprocessable_entity # Código 422 indica que a requisição não pôde ser processada
    end
  end

  # Para um sistema completo, você precisaria de uma ação destroy para logout:
  # def destroy
  #   session[:user_id] = nil
  #   flash[:notice] = 'Logout realizado com sucesso.'
  #   redirect_to login_path # Redireciona para a página de login após logout
  # end

end