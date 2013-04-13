class Index
  include Magaz::Api

  def products
    api.products.all.decorate
  end

  def products_recomed
    api.products.all.take(3)
  end

  def products_new
    api.products.all.take(3)
  end

  def categories
    api.categories.all.decorate
  end

  def categories_popular
    api.categories.all.take(6)
  end

end