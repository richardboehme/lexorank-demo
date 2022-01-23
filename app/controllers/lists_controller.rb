# frozen_string_literal: true

class ListsController < ApplicationController
  def index
  end

  def show
    @list = @lists.find(params[:id])
    @items = @list.items.ranked
    unless turbo_frame_request?
      @lists = @session.lists.ranked
    end
  end

  def create
    list = List.new(name: params[:list][:name], session: @session)
    list.move_to(@lists.size)

    if list.save
      flash.now[:success] = [{ title: 'List successfully created!' }]
    else
      flash.now[:danger] = list.errors.full_messages.map { |messages| { title: 'Error while creating a new list!', message: messages } }
    end

    respond_with_turbo_stream(fallback: list.persisted? ? list_path(list) : lists_path) do
      if list.persisted?
        turbo_stream.append(:lists, partial: 'lists/list', locals: { list: list, list_counter: @lists.size }) +
          turbo_stream.replace(:current_list, partial: 'lists/load_show', locals: { list: list })
      end
    end
  end

  def update_position
    list = @session.lists.find(params[:id].to_i)
    list.move_to!(params[:position].to_i)
    respond_to do |format|
      format.json { render json: { rank: list.rank } }
      format.html { redirect_to list_path(list) }
    end
  end

  def destroy
    list = @lists.find(params[:id])
    if list.destroy
      new_list = @lists.find_by('rank > ?', list.rank)

      new_list ||= @lists.last

      respond_with_turbo_stream(fallback: new_list ? list_path(new_list) : lists_path) do
        turbo_stream.remove(list) + turbo_stream.replace(:current_list, partial: 'lists/load_show', locals: { list: new_list })
      end
    end
  end
end
