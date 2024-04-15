require 'rails_helper'

describe FlickrImage do
  context ".new" do
    it "initializes object with id/owner/url" do
      image = FlickrImage.new(id: 123, title: "something", url: "http://example.com/image.jpg", owner_name: "JSmith")
      expect(image.id).to eq(123)
      expect(image.title).to eq("something")
      expect(image.url).to eq("http://example.com/image.jpg")
      expect(image.owner_name).to eq("JSmith")
    end
  end
end