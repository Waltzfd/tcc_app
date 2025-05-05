# app/controllers/daily_food_logs_controller.rb
# /daily_food_logs/new
class DailyFoodLogsController < ApplicationController
  before_action :set_daily_food_log, only: [:show, :edit, :update, :destroy]

  # GET /daily_food_logs
  # Mostra uma lista de todos os registros
  def index
    @daily_food_logs = DailyFoodLog.all # Busca todos os registros
  end

  # GET /daily_food_logs/1
  # Mostra um registro específico
  def show
    # @daily_food_log é definido pelo before_action :set_daily_food_log
  end

  # GET /daily_food_logs/new
  # Mostra o formulário para criar um novo registro
  def new
    @daily_food_log = DailyFoodLog.new # Inicializa um novo objeto para o formulário
  end

  # GET /daily_food_logs/1/edit
  # Mostra o formulário para editar um registro existente
  def edit
    # @daily_food_log é definido pelo before_action :set_daily_food_log
  end

  # POST /daily_food_logs
  # Cria um novo registro com os dados do formulário 'new'
  def create
    @daily_food_log = DailyFoodLog.new(daily_food_log_params) # Cria o objeto com os parâmetros permitidos

    if @daily_food_log.save # Tenta salvar no banco de dados
      # Redireciona para a página do registro criado ou para a lista, com uma mensagem de sucesso
      redirect_to @daily_food_log, notice: 'Registro de alimentação diária criado com sucesso!'
    else
      # Se houver erros, renderiza novamente o formulário 'new' com os erros
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /daily_food_logs/1
  # Atualiza um registro existente com os dados do formulário 'edit'
  def update
    # @daily_food_log é definido pelo before_action :set_daily_food_log

    if @daily_food_log.update(daily_food_log_params) # Tenta atualizar no banco de dados
      # Redireciona para a página do registro atualizado ou para a lista, com uma mensagem de sucesso
      redirect_to @daily_food_log, notice: 'Registro de alimentação diária atualizado com sucesso!'
    else
      # Se houver erros, renderiza novamente o formulário 'edit' com os erros
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /daily_food_logs/1
  # Exclui um registro
  def destroy
    @daily_food_log.destroy # Tenta excluir do banco de dados
    # Redireciona para a lista de registros, com uma mensagem de sucesso
    redirect_to daily_food_logs_url, notice: 'Registro de alimentação diária excluído com sucesso!'
  end

  private
  # Use callbacks para compartilhar configurações comuns entre as ações.
  def set_daily_food_log
    @daily_food_log = DailyFoodLog.find(params[:id]) # Busca o registro pelo ID na URL
  end

  # Apenas permite uma lista confiável de parâmetros.
  # Isto é crucial para segurança (Strong Parameters).
  # Certifique-se que todos os campos do seu formulário estão listados aqui.
  def daily_food_log_params
    params.require(:daily_food_log).permit(
      :log_date,
      :breakfast_details,
      :breakfast_calories,
      :lunch_details,
      :lunch_calories,
      :snack_details,
      :snack_calories,
      :dinner_details,
      :dinner_calories
    # Adicione aqui quaisquer outros campos que você adicionar ao formulário e ao modelo
    )
  end
end