class BaseController < ApplicationController
  def index
    @news_articles = NewsArticle.all
  end
end
