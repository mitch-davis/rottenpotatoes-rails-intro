class MoviesController < ApplicationController

  #def movie_params
  #  params.require(:movie).permit(:title, :rating, :description, :release_date)
  #end

  def show
    flash[:notice] = "#{params}"
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # "initialize" session variables
    if session[:ratings] == NIL
      @all = {}
      Movie.get_ratings.each do |next_rating|
        @all[:"#{next_rating}"] = 1
      end
      session[:ratings] = @all
      session[:sort_by] = "title" #default
    end
    
    # update session variables as necessary
    if params.has_key? :ratings and params.has_key? :sort_by
      session[:ratings] = params[:ratings]
      session[:sort_by] = params[:sort_by]
    elsif params.has_key? :ratings
      session[:ratings] = params[:ratings]
      #flash[:notice] = "rating filter #{session[:sort_by]}"
    elsif params.has_key? :sort_by
      session[:sort_by] = params[:sort_by]
    end
    
    #select movies which match rating criteria; sort by specified sort type  
    @movies = Movie.where(:rating => session[:ratings].keys).order(session[:sort_by])

    #set the sort column (for highlighting column header)
    @sort_column = session[:sort_by]
    #all possible ratings
    @all_ratings = Movie.get_ratings
  end

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
end
