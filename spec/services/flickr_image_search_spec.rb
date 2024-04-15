require 'rails_helper'
include FlickrApi

describe FlickrImageSearch do
  before do
    stub_flickr_get_methods
  end

  context ".call with an empty search term" do
    it "calls the flickr api to fetch recent images" do
      stubbed_api_response = {
        "photos": {
          "page": 1,
          "pages": 1,
          "perpage": 8,
          "total": 2,
          "photo": [
            { "id": "123456789", "owner": "3456@N07", "secret": "abcdef123", "server": "65535", "farm": 66, "title": "Something", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
            { "id": "2345678901","owner": "987654@N00", "secret": "4e1fac4857", "server": "65535", "farm": 66, "title": "Another", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
          ]
        },
        "stat": "ok"
      }
      stub_request(:post, "https://api.flickr.com/services/rest/").
        with(body: {"content_types" => "0", "format" => "json", "method" => "flickr.photos.getRecent", "nojsoncallback" => "1", "per_page" => "8", "safe_search" => "1"}).
          to_return(status: 200, body: stubbed_api_response.to_json, headers: {})
          
      result = FlickrImageSearch.call("")
      expect(result.size).to eq(2)
      expect(result.first.id).to eq("123456789")
      expect(result.first.owner).to eq("3456@N07")
      expect(result.first.url).to eq("https://farm66.staticflickr.com/65535/123456789_abcdef123.jpg")
      expect(result.last.id).to eq("2345678901")
      expect(result.last.owner).to eq("987654@N00")
      expect(result.last.url).to eq("https://farm66.staticflickr.com/65535/2345678901_4e1fac4857.jpg")
    end
  end

  context ".call with a search term" do
    it "calls the flickr api to fetch related images" do
      stubbed_api_response = {
        "photos": {
          "page": 1,
          "pages": 1,
          "perpage": 8,
          "total": 2,
          "photo": [
            { "id": "123456789", "owner": "3456@N07", "secret": "abcdef123", "server": "65535", "farm": 66, "title": "Something", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
            { "id": "2345678901", "owner": "987654@N00", "secret": "4e1fac4857", "server": "65535", "farm": 66, "title": "Another", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
          ]
        },
        "stat": "ok"
      }
      stub_request(:post, "https://api.flickr.com/services/rest/").
        with(body: {"content_types" => "0", "format" => "json", "method" => "flickr.photos.search", "nojsoncallback" => "1", "per_page" => "8", "safe_search" => "1", "text" => "dogs with sunglasses"}).
          to_return(status: 200, body: stubbed_api_response.to_json, headers: {})

      result = FlickrImageSearch.call("dogs with sunglasses")
      expect(result.size).to eq(2)
      expect(result.first.id).to eq("123456789")
      expect(result.first.owner).to eq("3456@N07")
      expect(result.first.url).to eq("https://farm66.staticflickr.com/65535/123456789_abcdef123.jpg")
      expect(result.last.id).to eq("2345678901")
      expect(result.last.owner).to eq("987654@N00")
      expect(result.last.url).to eq("https://farm66.staticflickr.com/65535/2345678901_4e1fac4857.jpg")
    end
  end
end