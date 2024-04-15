class FlickrImage
  attr_accessor :id, :title, :owner_name, :url

  def initialize(id:, title:, owner_name:, url:)
    @id, @title, @owner_name, @url = id, title, owner_name, url
  end
end