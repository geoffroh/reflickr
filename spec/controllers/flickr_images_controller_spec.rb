require 'rails_helper'

describe FlickrImagesController do
  context "#index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end