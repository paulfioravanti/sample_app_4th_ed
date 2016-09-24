class ApplicationController < ActionController::Base
  include Authenticatable

  protect_from_forgery with: :exception

  def self.local_prefixes
    ['shared', 'layouts', controller_path]
  end
  private_class_method :local_prefixes
end
