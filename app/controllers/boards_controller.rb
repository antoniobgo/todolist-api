class BoardsController < ApplicationController

  # authentication is the method we define in application_controller.rb to check request.headers['token']
  
    before_action :authentication
  
    # GET /todos
    def index
      @boards = Board.all
  
      render json: @boards
    end
end