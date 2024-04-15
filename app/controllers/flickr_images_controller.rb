class FlickrImagesController < ApplicationController
  def index
    @flickr_images = FlickrImageSearch.call(params[:search_term])
  end
end
