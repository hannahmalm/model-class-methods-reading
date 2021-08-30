class PostsController < ApplicationController

  def index
    #provide a list of authors to the view for the filter control
    @authors = Author.all

    #filter the @posts list based on user input - this is the logic used to get the filter in posts/index
    #this is filtering by author
    if !params[:author].blank?
      #@posts = Post.where(author: params[:author])
      #Post.by_author is a method in the model
      @posts = Post.by_author(params[:author])
    #this is filtering by date
    elsif !params[:date].blank?
      if params[:date] == "Today"
      #@posts = Post.where("created_at >=?", Time.zone.today.beginning_of_day)
      @posts = Post.from_today
      else
      #@posts = Post.where("created_at <?", Time.zone.today.beginning_of_day)
      @posts = Post.old_news
      end 
    else 
      #if no filters are applied, show all posts
      @posts = Post.all 
    end 
  end



  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end
end
