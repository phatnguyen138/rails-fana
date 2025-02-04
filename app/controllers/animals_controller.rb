class AnimalsController < ApplicationController
  before_action :set_animal, only: %i[ show edit update destroy ]

  # GET /animals
  def index
    @animals = Animal.all
  end

  # GET /animals/1
  def show
  end

  # GET /animals/new
  def new
    @animal = Animal.new
  end

  # GET /animals/1/edit
  def edit
  end

  # POST /animals
  def create
    @animal = Animal.new(animal_params)

    if @animal.save
      PrometheusExporter.animal_creation_counter.increment
      redirect_to @animal, notice: "Animal was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /animals/1
  def update
    if @animal.update(animal_params)
      redirect_to @animal, notice: "Animal was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /animals/1
  def destroy
    @animal.destroy!
    redirect_to animals_url, notice: "Animal was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def animal_params
      params.require(:animal).permit(:name, :species, :age)
    end
end
