class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def self.local_prefixes
    ['layouts', controller_path]
  end
  private_class_method :local_prefixes
end
