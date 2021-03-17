class ListsController < ApplicationController
  before_action :set_session

  def index
    @lists = @session.lists.ranked
  end

  def show
    @list = @session.lists.find(params[:id])
    @items = @list.items.ranked
  end

  def create
    list = List.new(name: params[:list][:name], session: @session)
    list.move_to(@session.lists.ranked.count)

    if list.save
      flash.now[:success] = [{ title: 'List successfully created!' }]
    else
      flash.now[:danger] = list.errors.full_messages.map { |messages| { title: 'Error while creating a new list!', message: messages } }
    end

    respond_with_turbo_stream(fallback: lists_path) do
      if list.persisted?
        turbo_stream.append(:lists, list) + turbo_stream.replace(:current_list, partial: 'lists/load_show', locals: { list: list })
      end
    end
  end

  def update_position
    list = @session.lists.find(params[:id].to_i)
    list.move_to!(params[:position].to_i)
    render json: { rank: list.rank }
  end

  def destroy
    list = @session.lists.find(params[:id])
    if list.destroy
      new_list = @session.lists.ranked.find_by('rank > ?', list.rank)

      unless new_list
        new_list = @session.lists.ranked.last
      end

      respond_with_turbo_stream(fallback: lists_path) do
        turbo_stream.remove(list) + turbo_stream.replace(:current_list, partial: 'lists/load_show', locals: { list: new_list })
      end
    end
  end

  def set_session
    @session = Session.find_by!(session_id: session.id)
  end

end
