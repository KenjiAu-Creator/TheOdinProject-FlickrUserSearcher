module UsersHelper
  def staticURL(photo)
      # This help will take in the photo model array and return an array of the photo URLs that will be displayed.
      # http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
      photoStaticURLs = []
      photo.each do |p|
        # We need the farm id, server-id, id, and secret from each photo first.
        farmId = p["farm"]
        serverId = p["server"]
        photoId = p["id"]
        secretId = p["secret"]

        # Next the URL is created

        staticURL = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{photoId}_#{secretId}.jpeg"
        photoStaticURLs.push(staticURL)
      end

      return photoStaticURLs
  end
end
