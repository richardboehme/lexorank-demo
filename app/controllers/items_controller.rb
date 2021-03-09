class ItemsController < ApplicationController
  before_action :set_session
  before_action :set_list

  def create
    item = Item.new(list: @list, name: params[:item][:name])
    item.move_to(@list.items.ranked.count)
    if item.save
      flash.now[:success] = [{ title: 'Item successfully created!' }]
    else
      flash.now[:danger] = item.errors.full_messages.map { |messages| { title: 'Error while creating a new item!', message: messages } }
    end

    respond_with_turbo_stream(fallback: lists_path) do
      if item.persisted?
        turbo_stream.append(:items, item)
      end
    end
  end

  def update_position
    item = @list.items.find(params[:id].to_i)
    item.move_to!(params[:position].to_i)
    render json: { rank: item.rank }
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
    @list = @session.lists.find(params[:list_id].to_i)
  end

  def set_session
    @session = Session.find_by!(session_id: session.id)
  end

end
