window.Magaz = window.Magaz || {}
window.Magaz.Thumbnail = {}
Thumbnail = window.Magaz.Thumbnail

Thumbnail.url = (cloudinary_identifier, crop, size) ->
  cloudinary_base_url = window.CLOUDINARY_BASE_URL

  crop.width  = crop.x2 - crop.x1
  crop.height = crop.y2 - crop.y1

  transformation = "x_#{crop.x1},y_#{crop.y1},w_#{crop.width},h_#{crop.height},c_crop/w_#{size},h_#{size},c_scale/"

  cloudinary_base_url + transformation + cloudinary_identifier