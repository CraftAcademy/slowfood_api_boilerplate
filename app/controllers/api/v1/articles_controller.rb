class Api::V1::ArticlesController < ApplicationController
  def create
    article = Article.create(article_params)

    if article.persisted? && attach_image(article)
      
      render json: { message: 'Your article was successfully created' }
    else
      binding.pry
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def attach_image(article)
    params_image = params['article']['image']

    if params_image.present?
      DecodeService.attach_image(params_image, article.image)
    end
  end
end
