module FlickrApi
  def stub_flickr_get_methods
    stub_request(:post, "https://api.flickr.com/services/rest/").
      with(:body => {"format"=>"json", "method"=>"flickr.reflection.getMethods", "nojsoncallback"=>"1"}).
      to_return(status: 200, body: {"methods":{"method":[{"_content":"flickr.photos.getRecent"},{"_content":"flickr.photos.search"}]},"stat":"ok"}.to_json, headers: {})
  end
end