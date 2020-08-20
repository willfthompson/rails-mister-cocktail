class DosesController < ApplicationController
  def new
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(params_format)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    dose = Dose.find(params[:id])
    dose.destroy
    redirect_to cocktail_path(Cocktail.find(dose.cocktail_id))
  end

  private

  def params_format
    params.require(:dose).permit(:description, :ingredient_id)
  end
end


# class CocktailsController < ApplicationController
#   def index
#     @cocktails = Cocktail.all
#   end

#   def show
#     @cocktail = Cocktail.find(params[:id])
#     @dose = Dose.new
#   end

#   def new
#     @cocktail = Cocktail.new
#   end

#   def create
#     @cocktail = Cocktail.new(params_format)
#     if @cocktail.save
#       redirect_to cocktail_path(@cocktail)
#     else
#       render :new
#     end
#   end

#   private

#   def params_format
#     params.require(:cocktail).permit(:name)
#   end
# end
