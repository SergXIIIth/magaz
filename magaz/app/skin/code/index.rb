class Index
  def products
    api.products.all.decorate
  end

  def categories
    api.categories.all.decorate
  end

  def render_partial_head
    api.render_partial 'head'
  end
end