class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  
  def index
    if user_signed_in?  
    @items = Item.where(:user_id => current_user).order("created_at DESC")
    end
  end
  

  def new
    @item = current_user.items.build
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
  end

  def edit
  end
  
  def update
   if @item.update(item_params)
      redirect_to item_path(@item)
   else
    render 'edit'
   end
  end
  
  def destroy
    @item.destroy
    redirect_to root_path
  end
  
  def completed
    @item = Item.find(params[:id])
    @item.update_attribute(:completed, true)
    redirect_to items_path
  end
  
  private
  
  # authorize @item

  
  def item_params
    params.require(:item).permit(:name, :user)
  end
  
  def find_item
    @item = Item.find(params[:id])
  end
end
