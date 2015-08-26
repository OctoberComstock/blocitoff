class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  
  def index
    @items = Item.all
    @items = Item.where(user: current_user)
  end
  

  def new
    @item = Item.new
    # authorize @item
  end
  
  def create
    @item = current_user.items.build(item_params)
    @item.expires_at = Time.now + 7.days
    # authorize @item
     if @item.save
      redirect_to @item, notice: "Item was added!"
     else
       flash[:error] = "Error adding item. Please try again! Your organization depends on it!"
       render :new
     end
  end
  
  def show
    @item = Item.find(params[:id])
    @item.days_left 
  end
  
  #Example of good whitelisting
  # def update
  #   user = User.find(params[:id])
  #   user.update_attributes user_params
  # end

  # private
  # def user_params
  #   params[:user].slice :first_name, :last_name, :email
  # end 
  

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:notice] = "Item was updated."
       redirect_to item_path
    else
       flash[:error] = "There was an error saving the item. Please try again."
       render 'edit'
    end
  end
  
  def destroy
    @item.destroy
    redirect_to items_path
  end
  
  def completed
    @item = Item.find(params[:id])
    @item.update_attribute(:completed, true)
    redirect_to items_path
  end
  
  private
  
  # authorize @item

  
  def item_params
    params.require(:item).permit(:name, :user, :description)
  end
  
  def find_item
    @item = Item.find(params[:id])
  end
end
