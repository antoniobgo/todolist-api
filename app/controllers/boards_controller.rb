# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :authorized

  # GET /todos
  def index
    @boards = Board.all

    render json: @boards
  end

  def user_boards
    render json: current_user.boards
  end
end
