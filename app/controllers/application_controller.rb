class ApplicationController < ActionController::Base

  def is_like(query)
    "%#{query}%"
  end

end
