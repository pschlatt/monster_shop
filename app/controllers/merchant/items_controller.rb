class Merchant::ItemsController < ApplicationController
  def index
    @merchant = current_user.merchant
    @items = @merchant.items
  end

  def new
    @merchant = current_user.merchant
  end

  def edit
    @merchant = current_user.merchant
    @item = Item.find(params[:id])
  end

  def update
    @merchant = current_user.merchant
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to merchant_items_index_path
      flash[:notice] = "#{@item.name} has been updated!"
    else
      flash[:alert] = @item.errors.full_messages.to_sentence
      render :edit
    end
  end

  def create
    @merchant = current_user.merchant
    @item = @merchant.items.new(item_params)
    if @item.save
      redirect_to merchant_items_index_path
      flash[:notice] = "#{@item.name} has been created"
    else
      flash[:alert] = @item.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:alert] = "#{item.name} has been deleted!"
    redirect_to merchant_items_index_path
  end

  def activate
    @item = Item.find(params[:id])
    @item.update(active: true)
    redirect_to "/merchant/#{current_user.merchant_id}/items"
    flash[:notice] = "#{@item.name} is for sale"
  end

  def deactivate
    @item = Item.find(params[:id])
    @item.update(active: false)
    redirect_to "/merchant/#{current_user.merchant_id}/items"
    flash[:alert] = "#{@item.name} is no longer for sale"
  end

  private

  def item_params
    params.permit(:name, :description, :price, :image, :inventory)
  end
end
