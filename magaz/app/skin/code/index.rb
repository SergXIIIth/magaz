class Index
  include Magaz::Api

  def products
    api.products.all.decorate
  end

  def categories
    api.categories.all.decorate
  end

end