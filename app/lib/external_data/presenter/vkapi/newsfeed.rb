class ExternalData::Presenter::Vkapi::Newsfeed < ExternalData::Presenter
  def text
    data.text.truncate 400
  end

  def fulltext
    model.data['text']
  end

  def group?
    data.owner_type == 'group'
  end

  def owner_name
    case data.owner_type
      when 'group'
        data.group.name
      when 'profile'
        data.profile.first_name + ' ' + data.profile.last_name
    end
  end

  def data
    @_data ||= RecursiveOpenStruct.new model.data
  end

  def url
    'https://vk.com/wall' + data.from_id.to_s + '_' + data.id.to_s
  end
end
