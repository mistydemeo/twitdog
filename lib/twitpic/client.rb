require "httparty"
require "open-uri"

module Twitpic
  class Client
    include HTTParty
    format :json
    base_uri "http://api.twitpic.com/2"

    def get uri, params
      # twitpic's API is not doing so well under load right now -
      # this has a moderate chance of returning 502.
      # Loop over it until there's a good result.
      run = 1
      begin
        response = self.class.get uri, query: params
        sleep 5 if run > 1
        run += 1
      end while response.code == 502

      response
    end

    def user name
      User.new self, get("/users/show.json", username: name)
    end

    def images username, page
      user = get "/users/show.json", username: username, page: page
      user["images"]
    end
  end

  class User
    attr_accessor :username, :photo_count, :record

    def initialize client, hsh
      @client = client

      @username = hsh["username"]
      @photo_count = hsh["photo_count"].to_i
      @images_per_page = hsh["images"].count
      @pages = (@photo_count.to_f / @images_per_page).ceil
      @record = hsh
    end

    def each_image
      return to_enum(:each_image) unless block_given?

      (1..@pages).each do |page|
        images = @client.images(@username, page)
        images.each {|i| yield Image.new(@client, i)}
      end
    end

    def to_json opts=nil
      @record.to_json(opts)
    end
  end

  class Image
    attr_accessor :id, :record

    def initialize client, hsh
      @client = client
      @id = hsh["short_id"]
      @record = hsh
    end

    def url
      "https://twitpic.com/show/large/#{@id}"
    end

    def download path
      response = @client.get("/media/show.json", id: @id)

      json_path = File.join(path, "#{@id}.json")
      File.open(json_path, "w") {|f| f.write response.to_json}

      image_path = File.join(path, "#{@id}.jpg")
      # Image serving is spotty at the moment.
      loop do
        begin
          File.open(image_path, "w") {|f| f.write open(url).read}
          break
        rescue OpenURI::HTTPError => e
          raise e unless e.message =~ /(Bad Gateway|Internal Server Error)/
          sleep 5
        end
      end
    end
  end
end
