class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  def index
    
    sort = params[:sort] || session[:sort]
    @all_ratings = Movie.all_ratings
    
    case sort
    when 'title'
      @title_header = 'hilite'
      @movies = Movie.order(:title)
      session[:sort] = 'title'
      if session[:ratings] != nil
        @selected_ratings = session[:ratings]
        @movies = @movies.where(:rating => @selected_ratings.keys)
      end
      return
    when 'release_date'
      @date_header = 'hilite'
      @movies = Movie.order(:release_date)
      session[:sort] = 'release_date'
      if session[:ratings] != nil
        @selected_ratings = session[:ratings]
        @movies = @movies.where(:rating => @selected_ratings.keys)
      end
      return
    end
    
    @selected_ratings = params[:ratings] || session[:ratings] || {}
    
    if @selected_ratings == {}
      @movies = Movie.all
    end
    
    if session[:sort] == 'title'
      @movies = @movies.order(:title)
    end
    
    if session[:sort] == 'release_date'
      @movies = @movies.order(:release_date)
    end
    
    if params[:session] == "clear"
      session[:sort] = nil
      session[:rating] = nil
    end
    
    if params[:ratings] != nil
      @selected_ratings = params[:ratings]
      @movies = @movies.where(:rating => @selected_ratings.keys)
      session[:ratings] = @selected_ratings
    end
    
    if session[:ratings] != nil
      @movies = @movies.where(:rating => session[:ratings].keys)
    end
    
    
      
  end

  #def index
  #  @movies = Movie.all
  #end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
