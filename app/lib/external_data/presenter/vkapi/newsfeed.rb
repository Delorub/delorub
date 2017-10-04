class ExternalData::Presenter::Vkapi::Newsfeed < ExternalData::Presenter
  def text
    data.text.truncate 400
  end

  def fulltext
    data.text
  end

  def data
    @_data ||= OpenStruct.new model.data
  end

  def url
    'https://vk.com/wall' + data.from_id.to_s + '_' + data.id.to_s
  end
end
