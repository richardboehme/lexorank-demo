# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_list

  def create
    item = Item.new(list: @list, name: params[:item][:name])
    @items = @list.items.ranked
    item.move_to(@items.count)
    if item.save
      flash.now[:success] = [{ title: 'Item successfully created!' }]
    else
      flash.now[:danger] = item.errors.full_messages.map { |messages| { title: 'Error while creating a new item!', message: messages } }
    end

    respond_with_turbo_stream(fallback: list_path(@list)) do
      if item.persisted?
        turbo_stream.append(:items, partial: 'items/item', locals: { item: item, item_counter: @items.count })
      end
    end
  end

  def update_position
    item = @list.items.find(params[:id].to_i)
    item.move_to!(params[:position].to_i)
    respond_to do |format|
      format.json { render json: { rank: item.rank } }
      format.html { redirect_to list_path(item.list) }
    end
  end

  def destroy
    item = @list.items.find(params[:id].to_i)
    if item.destroy
      respond_with_turbo_stream(fallback: list_path(item.list)) do
        turbo_stream.remove(item)
      end
    end
  end

  def set_list
    @list = @lists.find(params[:list_id].to_i)
  end
end
