class ApplicationController < ActionController::Base
  before_action :write_session

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

  def write_session
    session[:last_request] = Time.current
  end

end
