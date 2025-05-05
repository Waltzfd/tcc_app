class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: %i[ show edit update destroy ]

  # GET /meal_plans or /meal_plans.json
  def index
    @meal_plans = MealPlan.all
  end

  # GET /meal_plans/1 or /meal_plans/1.json
  #def show
  #end

  #se der problema só trocar
  def show
    # Encontra o plano de alimentação pelo ID.
    # Usamos includes para carregar as associações necessárias e evitar problemas de N+1 queries.
    @meal_plan = MealPlan.includes(meals: [:recipes, { meal_ingredients: :ingredient }]).find(params[:id])

    # Você pode adicionar lógica de autorização aqui, por exemplo:
    # authorize @meal_plan # Se estiver usando um gem como Pundit ou CanCanCan
  rescue ActiveRecord::RecordNotFound
    # Lida com o caso em que o plano de alimentação não é encontrado
    flash[:alert] = "Plano de alimentação não encontrado."
    redirect_to meal_plans_path # Redireciona para a lista de planos (ajuste o caminho se necessário)
  end

  # GET /meal_plans/new
  def new
    @meal_plan = MealPlan.new
  end

  # GET /meal_plans/1/edit
  def edit
  end

  # POST /meal_plans or /meal_plans.json
  def create
    @meal_plan = MealPlan.new(meal_plan_params)

    respond_to do |format|
      if @meal_plan.save
        format.html { redirect_to @meal_plan, notice: "Meal plan was successfully created." }
        format.json { render :show, status: :created, location: @meal_plan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meal_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meal_plans/1 or /meal_plans/1.json
  def update
    respond_to do |format|
      if @meal_plan.update(meal_plan_params)
        format.html { redirect_to @meal_plan, notice: "Meal plan was successfully updated." }
        format.json { render :show, status: :ok, location: @meal_plan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meal_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meal_plans/1 or /meal_plans/1.json
  def destroy
    @meal_plan.destroy!

    respond_to do |format|
      format.html { redirect_to meal_plans_path, status: :see_other, notice: "Meal plan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  #def set_meal_plan
  #@meal_plan = MealPlan.find(params.expect(:id))
  # end



def meal_plan_params
  params.expect(meal_plan: [ :start_date, :end_date, :user_id ])
  end
  # se der problema excluir daqui

  def meal_plan_params
  params.require(:meal_plan).permit(
    :name, :date, # Outros atributos do MealPlan
    meals_attributes: [
      :id, :category, :_destroy, # Permitir _destroy para remover refeições inteiras (opcional)
      meal_ingredients_attributes: [
        :id, :ingredient_id, :quantity, :_destroy # Permitir :id e :_destroy
      ]
    ]
  )
  end
end

