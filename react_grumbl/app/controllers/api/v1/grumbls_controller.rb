class Api::V1::GrumblsController < ApplicationController
  def index
    grumbl = Grumbl.all.order(created_at: :desc)
    render json: grumbl
  end

  def create
    grumbl = Grumbl.create!(grumbl_params)
    if grumbl
      render json: grumbl
    else
      render json: grumbl.errors
    end
  end

  def show
    if grumbl
      render json: grumbl
    else
      render json: grumbl.errors
    end
  end

  def destroy
    grumbl&.destroy
    render json: { message: 'Grumbl deleted!' }
  end

  private

  def grumbl_params
    params.permit(:name, :image, :ingredients, :instruction)
  end

  def grumbl
    @grumbl ||= Grumbl.find(params[:id])
  end
end
