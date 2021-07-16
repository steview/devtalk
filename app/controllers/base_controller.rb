class BaseController < ApplicationController
  def index
    Rails.application.load_seed
    @news_articles = NewsArticle.all
  end
end
