class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  def frontend
    render file: Rails.root.join('public', 'index.html')
  end
end
