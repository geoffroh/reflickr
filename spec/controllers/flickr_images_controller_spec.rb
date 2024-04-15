require 'rails_helper'
include FlickrApi

describe FlickrImagesController do
  before do
    stub_flickr_get_methods
    stubbed_api_response = {"photos": {"page": 1, "pages": 1, "perpage": 8, "total": 0, "photo": []}, "stat": "ok"}
    stub_request(:post, "https://api.flickr.com/services/rest/").
      with(body: {"content_types" => "0", "format" => "json", "method" => "flickr.photos.getRecent", "nojsoncallback" => "1", "per_page" => "8", "safe_search" => "1", "extras"=>"owner_name"}).
        to_return(status: 200, body: stubbed_api_response.to_json, headers: {})
  end

  context "#index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "passes the search term query param to the FlickrImageSearch service" do
      expect(FlickrImageSearch).to receive(:call).with("term")
      get :index, params: { search_term: "term"}
    end
  end
end