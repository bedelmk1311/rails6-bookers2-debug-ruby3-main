class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    #Userモデルで定義したfollowメソッド発動
    redirect_to request.referer
    #遷移元のURL情報を取得 =同じ画面に戻る
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    #Userモデルで定義したunfollowメソッド発動
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    #対象のuserを特定
    @users = user.followings
    #フォローしているユーザーを取得(Userモデルで定義)
  end
  
  def followers
    user = User.find(params[:user_id])
    #対象のuserを特定
    @users = user.followers
    #フォロワーを取得(Userモデルで定義)
  end

end
