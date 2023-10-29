class RelationshipsController < ApplicationController
  
  def create
    current_user.follow(params[:user_id])
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
  end
  
  def followings
    user = User.find(params[:user_id])
    @users = user.following_users #Userモデルとのリレーションhas_manyで定義した名前？
  end
  
  def followers
    user＝User.find(params[:user_id])
    @users = user.followed_users
  end
  
end
