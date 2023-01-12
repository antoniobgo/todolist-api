# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :authorized
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  # GET /todos
  def index
    boards = Board.all
    render json: boards, status: 200
  end

  def create
    board = Board.new(board_params)
    board.user = current_user

    if board.save
      render json: {board: board.as_json(only: [:id, :title])}, status: 201
    else
      render json: {message: "couldnt create board"}, status: :unprocessable_entity
    end
  end

  def update
    board = Board.find(params[:id])
    board.title = params[:title]

    if board.save
      render json: {board: board.as_json(only: [:id, :title])}, status: 200
    else
      render json: {message: "couldnt create board"}, status: :unprocessable_entity
    end
  end

  def user_boards
    # boards = Board.find_by(user_id: current_user.id)
    render json: current_user.boards.sort_by(&:id)
  end

  private

  def board_params
    params.permit(:title)
  end

  def handle_record_not_found(e)
    render json: { message: 'Board not found' }, status: :unprocessable_entity
  end
end
