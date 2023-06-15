class ArticlesController < ApplicationController
  before_action :authenticate_user, only: %i[create update destroy]
  before_action :authorize_user, only: %i[update destroy]

  def create
    @article = @current_user.articles.build(article_params)
    @article.assign_tags(params[:article][:tagList])

    if @article.save
      render json: { article: article_response(@article) }, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def show
    @article = Article.find_by(slug: params[:slug])
    if @article
      render json: { article: article_response(@article) }, status: :ok
    else
      render json: { error: 'Article not found' }, status: :not_found
    end
  end

  def update
    @article = Article.find_by(slug: params[:slug])
    if @article&.update(article_params)
      render json: { article: article_response(@article) }, status: :ok
    else
      if @article
        render json: @article.errors, status: :unprocessable_entity
      else
        render json: { error: 'Article not found' }, status: :not_found
      end
    end
  end

  def destroy
    @article = Article.find_by(slug: params[:slug])
    if @article&.destroy
      render json: {}, status: :ok
    else
      if @article
        render json: @article.errors, status: :unprocessable_entity
      else
        render json: { error: 'Article not found' }, status: :not_found
      end
    end
  end

  def article_params
    params.require(:article).permit(:title, :description, :body, :tagList)
  end

  private

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

  def authorize_user
    @article = Article.find_by(slug: params[:slug])
    return if @article && (@article.user.id == @current_user.id)

    render json: { error: 'User not authorized' }, status: :unauthorized
  end
end
