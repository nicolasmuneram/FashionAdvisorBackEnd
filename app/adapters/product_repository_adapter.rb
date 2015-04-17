class ProductRepositoryAdapter

  def get_product(product_id)
    serialize Product.find_by_id(product_id)
  end

  def get_products(search_term)
    client = Shopsense::API.new({'partner_id' => 'uid9921-26902161-26'})
    response = client.search(search_term, 0, 10)
    raw_products = JSON.parse(response)["products"]
    raw_products
  end
  
  def search_product_details(product_id)
    p = JSON.parse(Net::HTTP.get(URI.parse("http://api.shopstyle.com/api/v2/products/#{product_id}?pid=uid9921-26902161-26")))
    products = {
        id: p['id'].to_i,
        name: p['name'],
        image_url: p['image']['sizes']['Large']['url'],
        description: p['description'],
        price: p['priceLabel'],
        retailer_url: p['clickUrl'],
        retailer: p['retailer']['name']
    }

    if(p['brand'] != nil)
      products['brand_name'] = p['brand']['name']
    else
      products['brand_name'] = nil
    end
    products
  end

  def serialize(product)
    entity = FashionAdvisorCore::Entities::Product.new(nil)
    if product!=nil
      entity = FashionAdvisorCore::Entities::Product.new(product.id)
    end
    entity
  end
end