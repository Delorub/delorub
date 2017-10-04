class ExternalData::Parser::Vkapi::Newsfeed < ExternalData::Parser
  attr_reader :vk_account

  def initialize vk_account
    @vk_account = vk_account
    super()
  end

  def fetch_data query
    api_request(query).items.each do |item|
      add_item item
    end
  end

  private

    def text item
      item['text']
    end

    def generate_uid item
      'vk' + item['from_id'].to_s + '_' + item['id'].to_s
    end

    def api_request query
      api.newsfeed.search(q: query, count: 200, extended: 1, fields: 'city')
    end

    def api
      @_api ||= VkontakteApi::Client.new(vk_account.access_token)
    end
end
