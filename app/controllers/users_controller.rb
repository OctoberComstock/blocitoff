class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  def show
    @user = User.find(params[:id])
    @item = Item.find(params[:item_id])
    @list = List.find(params[:list_id])
  end

  def index
  end

  def new
  end

  def edit
  end
end
