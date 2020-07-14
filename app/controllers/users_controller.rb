class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  require 'flickr'
  include UsersHelper

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    flickr = Flickr.new("1949c5657b6c444d9ff524b91d230aa7")

    # Below is the proper way but provides invalid key for some reason
    # flickr = Flickr.new(api_key: ENV["FLICKR_ACCESS_KEY"],
    #                     shared_secret: ENV["FLICKR_SECRET_KEY"])


    # Flickr’s API requires two steps to actually display a photo – you need to get a photo’s meta information 
    # (which we just received in our search results) and then you need to piece it together into a URL that Flickr 
    # can understand to actually retrieve the photo. The format they suggest is:
    # http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg

    search = params[:search]
    if search
      # @photos = flickr.people.getPublicPhotos(user_id: params[:search][:user_id])
      # @photos = flickr.people.getPhotos(user_id: params[:search][:user_id])
      
      @user = flickr.users(params[:search][:user_id])
      @photos = @user.photos
      @URLs = staticURL(@photos)
    end
    
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
    end
end
