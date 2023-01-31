class SectionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    render json: Board.find_by!(id: params[:board_id]).sections, status: 200
  end

  def create
    board = Board.find_by!(id: params[:board_id])
    section = Section.new(section_params)
    section.board = board
    if section.save
      render json: section, status: 201
    else
      render json: {message: "couldnt create section"}, status: :unprocessable_entity
    end
  end

  def update
    section = Section.find_by!(id: params[:id])
    section.title = params[:title]
    if section.save
      render json: {section: section.as_json(only: [:id, :title])}, status: 200
    else
      render json: {message: "couldnt update section"}, status: :unprocessable_entity
    end
  end

  def destroy
    section = Section.find_by!(id: params[:id])
    if section.destroy
      render :nothing, status: :no_content
    else
      render json: {message: "couldnt destroy section"}, status: :unprocessable_entity
    end
  end


  private
  
  def section_params
    params.permit(:title)
  end

  def handle_record_not_found(e)
    render json: { message: 'Board not found' }, status: :unprocessable_entity
  end
end
