class PersonsController < ApplicationController
  def profile
  	@people = User.all

  end
  private
  def person_params
    params.require(:user).permit(:email)
  end
end
