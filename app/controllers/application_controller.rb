class ApplicationController < ActionController::Base
  before_action :write_session
  before_action :set_session
  before_action :set_lists

  unless Rails.env.production?
    before_action do
      Prosopite.scan
    end

    after_action do
      Prosopite.finish
    end
  end

  def respond_with_turbo_stream(fallback: nil, &block)
    respond_to do |format|
      format.turbo_stream do
        streams =
          ''.tap do |out|
            out << block.call.to_s
            out << turbo_stream.append(:flash_messages, partial: 'layouts/flash') unless flash.empty?
          end
        render turbo_stream: streams
      end
      if fallback
        format.html { redirect_to fallback }
      end
    end
  end

  # We have to write something into the session to read from it
  def write_session
    session[:last_request] = Time.current
  end

  def set_session
    @session = Session.find_by!(session_id: session.id.private_id)
  end

  def set_lists
    @lists = @session.lists.ranked
  end

end
