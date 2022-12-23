class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    render json: Section.find_by!(id: params[:section_id]).items, status: 200
  end

  private

  def handle_record_not_found(e)
    render json: { message: 'Section not found' }, status: :unprocessable_entity
  end
end
