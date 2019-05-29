class CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    categories = Category.all

    render json: categories, status: :ok
  end


  def create
    return unless user_logged?

    category = Category.new( category_params )

    if category.save
      render json: category, status: :ok
    else
      render json: {'message': category.errors.full_message}, status: :internal_server_error
    end
  end


  def destroy
    return unless user_logged?

    category = Category.find( params[:id])

    if category.delete
      render json: category, status: 200
    else
      render json: {'message': category.errors.full_message}, status: :internal_server_error
    end
  end


  def show
    return unless user_logged?

    category = Category.find( params[:id] )

    render json: category, status: :ok
  end


  def update
    return unless user_logged?

    category = Category.find( params[:id] )

    if category.update( category_params )
      render json: category, status: 200
    else
      render json: {'message': category.errors.full_message}, status: :internal_server_error
    end
  end


  private

  def category_params
    params.require(:category).permit(:name)
  end
end
