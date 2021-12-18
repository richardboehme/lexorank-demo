ActiveSupport.on_load(:active_record) do
  ActionDispatch::Session::ActiveRecordStore.session_class = Session
end
