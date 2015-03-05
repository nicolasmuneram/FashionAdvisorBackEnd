module ShopStyleApiHelper

  # Search a product by a given ID in the ShopStyle API.
  # @param [Integer] id The id of the product wanted to fetch.
  # @return [Hash] Hash of the product information.
  def search_by_id(id)
    p = JSON.parse(Net::HTTP.get(URI.parse("http://api.shopstyle.com/api/v2/products/#{id}?pid=uid9921-26902161-26")))
    {
        :id => p["id"].to_i,
        :name => p["name"],
        :image_url => p["image"]["sizes"]["Large"]["url"],
        :description => p["description"],
        :price => p["priceLabel"],
        :retailer_url => p["url"],
        :brand_name => p["brandName"],
        :retailer => p["retailer"]["name"]
    }
  end

  # This method formats the hash that is returned from the ShopStyle API, adds a field
  # which tells if a product belongs to a users wardrobe.
  # @param [Hash] products_hash Raw Hash returned by the API
  # @return [Object] Returns the formatted hash with the proper keys and values.
  def format_products_hash(products_hash, user)
    @products = products_hash.map! do |p|

      image = p["images"].select { |i| i["sizeName"] == 'Large' }.pop
      p['in_wardrobe'] = false
      Product.create(p["id"].to_i)

      if user.has_product_in_wardrobe?(p["id"].to_i)
        p['in_wardrobe'] = true
      end
      p
    end
  end

end