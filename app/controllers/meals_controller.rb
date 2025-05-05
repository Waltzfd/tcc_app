class MealsController < ApplicationController
  before_action :set_meal, only: %i[ show edit update destroy ]

  # GET /meals or /meals.json
  #se der problema trocar esse index depoois
  def index
    # Busca as refeições do usuário logado para a data selecionada
    # Inclui meal_ingredients e ingredients para evitar N+1 queries
    @meals = current_user.meals.where(date: @date).includes(meal_ingredients: :ingredient).order(:meal_type)

    # Calcula o total de calorias para o dia
    @total_calories = @meals.sum do |meal|
      meal.meal_ingredients.sum { |mi| (mi.ingredient&.calories || 0) * mi.quantity }
      # Use &.calories para evitar erro se ingredient for nil (embora improável com belongs_to)
    end
  end

  #def index
  # @meals = Meal.all
  ##end

  # GET /meals/1 or /meals/1.json
  #se der problema alterar a show depois
  def show
    @meal = current_user.meals.find(params[:id])
  end

  #def show
  #end

  # GET /meals/new
  #se der problema trocar depois
  def new
    @meal = current_user.meals.new(date: @date)
  end

  #def new
  #@meal = Meal.new
  #end

  # GET /meals/1/edit
  def edit
  end

  #se der problema trocar depois
  def create
    @meal = current_user.meals.new(meal_params)
    @meal.user = current_user # Garante associação correta com o usuário

    if @meal.save
      redirect_to meals_path(date: @meal.date), notice: 'Refeição criada com sucesso.'
    else
      @date = @meal.date || Date.today
      render :new
    end
  end

  # POST /meals or /meals.json
  #def create
  # @meal = Meal.new(meal_params)

  # respond_to do |format|
  #   if @meal.save
  #     format.html { redirect_to @meal, notice: "Meal was successfully created." }
  #     format.json { render :show, status: :created, location: @meal }
  #   else
  #     format.html { render :new, status: :unprocessable_entity }
  #     format.json { render json: @meal.errors, status: :unprocessable_entity }
  #   end
  # end
  #end

  # PATCH/PUT /meals/1 or /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to @meal, notice: "Meal was successfully updated." }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1 or /meals/1.json
  def destroy
    @meal.destroy!

    respond_to do |format|
      format.html { redirect_to meals_path, status: :see_other, notice: "Meal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params.expect(:id))
    end
  # se der problema remoover set_date
  def set_date
    # Define a data a partir dos parâmetros da URL ou usa a data atual
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
  end

  #se der problema remover meal_params
  def meal_params
    params.require(:meal).permit(:meal_type, :date) # Permite apenas os atributos essenciais para criar uma refeição
  end
  end
    # Only allow a list of trusted parameters through.
  # def meal_params
  # params.expect(meal: [ :name, :date, :user_id ])
  # end
  #end
