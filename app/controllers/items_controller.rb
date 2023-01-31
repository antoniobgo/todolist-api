class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    render json: Section.find_by!(id: params[:section_id]).items, status: 200
  end

  def create
    section = Section.find_by!(id: params[:section_id])
    item = Item.new(item_params)
    item.section = section
    if item.save
      render json: item, status: 201
    else
      render json: {message: "couldnt create item"}, status: :unprocessable_entity
    end
  end

  def update
    item = Item.find_by!(id: params[:id])
    
    if item.update!(item_params)
      render json: {item: item.as_json(only: [:id, :title, :description])}, status: 200
    else
      render json: {message: "couldnt edit item"}, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      render :nothing, status: :no_content
    else
      render json: {message: "couldnt delete item"}, status: :unprocessable_entity
    end
  end

  private
  
  def item_params
    params.permit(:title, :description)
  end

  def handle_record_not_found(e)
    render json: { message: 'Section not found' }, status: :unprocessable_entity
  end
end
