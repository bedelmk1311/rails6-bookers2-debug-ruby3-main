class SearchesController < ApplicationController
  before_action :authenticate_user!
  #ユーザー認証　=アクションする前にログインしているかどうかを確認
  
  def search
    @model = params[:model]
    #リクエストから送られてきた値（ここではUserかBookモデル）がなんなのかを
    @keyword = params[:keyword]
    #ユーザーが入れた検索語句という意味でkeyword 
    @method = params[:method]
    #ユーザーが選択した４つの検索方法(search method)


    # 選択したモデルで条件分岐
    if @model  == "user"
      @results = User.search_for(@keyword, @method)
    else
      @results = Book.search_for(@keyword, @method)
      #search_for メソッド
    end
  end
end
