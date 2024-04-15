require 'rails_helper'

describe FlickrImage do
  context ".new" do
    it "initializes object with id/owner/url" do
      image = FlickrImage.new(id: 123, owner: "user456", url: "http://example.com/image.jpg")
      expect(image.id).to eq(123)
      expect(image.owner).to eq("user456")
      expect(image.url).to eq("http://example.com/image.jpg")
    end
  end
end