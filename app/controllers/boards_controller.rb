# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :authorized

  # GET /todos
  def index
    boards = Board.all

    render json: boards, status: 200
  end

  def create
    board = Board.new(board_params)
    board.user = current_user

    if board.save
      render json: board, status: 201
    else
      render json: {message: "couldnt create board"}, status: :unprocessable_entity
    end
  end

  def user_boards
    render json: current_user.boards
  end

  private

  def board_params
    params.permit(:title)
  end
end
