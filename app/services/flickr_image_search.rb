class FlickrImageSearch
  def self.call(search_term = "")
    results =
      if search_term.blank?
        Flickr.new.photos.getRecent(default_args)
      else
        Flickr.new.photos.search(default_args.merge(text: search_term))
      end

    results.map do |result|
      FlickrImage.new(id: result.id, url: Flickr.url(result), owner: result.owner)
    end
  end

  def self.default_args
    {
      per_page: 8,
      safe_search: 1,
      content_types: 0
    }
  end
end