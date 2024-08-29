class MiningTypesController < ApplicationController
  before_action :set_mining_type, only: %i[show edit update destroy]

  def index
    @mining_types = MiningType.all
  end

  def show; end

  def new
    @mining_type = MiningType.new
  end

  def edit; end

  def create
    @mining_type = MiningType.new(mining_type_params)
    if @mining_type.save
      redirect_to @mining_type, notice: 'Tipo de Mineração criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @mining_type.update(mining_type_params)
      redirect_to @mining_type, notice: 'Tipo de Mineração atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @mining_type.destroy
    redirect_to mining_types_url, notice: 'Tipo de Mineração apagado com sucesso.'
  end

  private

  def set_mining_type
    @mining_type = MiningType.find(params[:id])
  end

  def mining_type_params
    params.require(:mining_type).permit(:description, :acronym)
  end
end
