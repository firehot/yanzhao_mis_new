module ContentItemsHelper
  #根据content_class_code获取content_class_name
  def content_class_name(content_class_code)
    content_class = ContentClass.find_by_code(content_class_code)
    content_class.try(:name)
  end
end
