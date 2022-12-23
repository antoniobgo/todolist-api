class SectionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    render json: Board.find_by!(id: params[:board_id]).sections, status: 200
  end

  private

  def handle_record_not_found(e)
    render json: { message: 'Board not found' }, status: :unprocessable_entity
  end
end
