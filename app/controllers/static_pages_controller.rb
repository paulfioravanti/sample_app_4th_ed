class StaticPagesController < ApplicationController
  def show
    render params[:id]
  end

  def self.local_prefixes
    [controller_path]
  end
  private_class_method :local_prefixes
end
