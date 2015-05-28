class Arm11Controller < ApplicationController

def index
  if params[:name]
    @name = params[:name]
  else
    @name = "Elliot"
  end
end

end
