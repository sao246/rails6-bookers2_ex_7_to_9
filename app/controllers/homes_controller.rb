class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:about, :top]
  def top
  end
  
  def about
  end
end
