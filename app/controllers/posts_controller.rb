class PostsController < MessagesController
  protected
  #生成@search对象
  def create_search
    @search = @model_klazz.search(params[:search])
  end
end
