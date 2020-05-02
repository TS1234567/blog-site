class ProfilesController < ApplicationController
  
  def new
    @profile = Profile.new
  end
  
  def create
    @profile = current_user.profiles.build(profile_params)
    if (@profile.save)
      flash[:success]  = "プロフィールの投稿に成功しました"
      redirect_to user
    else
      flash[:error] = "レビューの投稿ができませんでした"
      render :new
    end  
  end
  
  def destroy
  end
  
  private
  
  def profile_params
    params.require(:profile).permit(:content)
  end

end
