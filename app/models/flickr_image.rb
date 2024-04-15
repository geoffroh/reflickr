class FlickrImage
  attr_accessor :id, :owner, :url

  def initialize(id:, owner:, url:)
    @id, @owner, @url = id, owner, url
  end
end