class PersonsController < ApplicationController
  def profile
  	@people = User.all
  	@user = current_user

  end
  private
  def person_params
    params.require(:user).permit(:email)
  end
end
