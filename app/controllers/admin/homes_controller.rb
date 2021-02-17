class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top; end

  # def search
  #   @comics = Comic.search(params[:search])
  # end
end
