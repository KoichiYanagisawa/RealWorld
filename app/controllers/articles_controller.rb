class ArticlesController < ApplicationController
  before_action :authenticate_user, only: :create
  def create
    @article = @current_user.articles.build(article_params)
    @article.assign_tags(params[:article][:tagList])

    if @article.save
      render json: { article: article_response(@article) }, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # 一旦タグの配列は無視してその他の記事の属性を取得することにする
  def article_params
    params.require(:article).permit(:title, :description, :body, :tagList)
  end

  def article_response(article)
    {
      "slug": article.slug,
      "title": article.title,
      "description": article.description,
      "body": article.body,
      "tagList": article.tags.map(&:name),
      "createdAt": article.created_at,
      "updatedAt": article.updated_at,
      "author": {
        "username": article.user.username,
        "bio": article.user.bio,
        "image": article.user.image,
        "following": false
      }
    }
  end

  def authenticate_user
    @current_user = decode_token
  end
end
