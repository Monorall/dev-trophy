class ApplicationJob < ActiveJob::Base
  queue_as :default
  sidekiq_options retry: 5
  
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked
   
  #ActiveRecord::Base.connection.execute("BEGIN TRANSACTION; END;")

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
