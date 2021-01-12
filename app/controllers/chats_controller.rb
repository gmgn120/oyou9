class ChatsController < ApplicationController
  
  before_action :authenticate_user!, only: [:create]
  
end
