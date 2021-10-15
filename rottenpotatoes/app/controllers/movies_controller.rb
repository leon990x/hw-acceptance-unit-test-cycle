class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
    sort = params[:sort] || session[:sort]
    
    if sort == 'title'
      ordering, @title_header = {:title => :asc}, 'hilite'
    elsif sort == 'release_date'
      ordering, @date_header = {:release_date => :asc}, 'hilite'
    end
    
    @all_ratings = Movie.all_ratings
    @ratings_selected = params[:ratings] || session[:ratings] || {}
    
    if @ratings_selected == {}
      @ratings_selected = Hash[@all_ratings.map {|rating| [rating, rating]}]
    end
    
    if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      session[:sort] = sort
      session[:ratings] = @ratings_selected
      redirect_to :sort => sort, :ratings => @ratings_selected and return
    end
    
    @movies = Movie.where(rating: @ratings_selected.keys).order(ordering)
  end
    
    

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def same
    
    @movie = Movie.find(params[:id])
    director = @movie.director
    
    if director.blank? == true 
      flash[:notice] = "'#{@movie.title}' has no director info."
      redirect_to movies_path
    else
      @movies = Movie.where(director: director)
    end
   
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
