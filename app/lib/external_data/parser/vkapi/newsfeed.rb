class ExternalData::Parser::Vkapi::Newsfeed < ExternalData::Parser
  attr_reader :vk_account

  def initialize vk_account
    Hashie.logger = Logger.new(nil)
    @vk_account = vk_account
    super()
  end

  def fetch_data query
    response = api_request(query)

    response.items.each do |item|
      add_item item.merge(owner_from_response(item, response))
    end
  end

  private

    def owner_from_response item, response
      if item.owner_id.to_s[0] == '-'
        {
          owner_type: 'group',
          group: response.groups.find { |e| e.id.to_s == item.owner_id.to_s[1..-1] }
        }
      else
        {
          owner_type: 'profile',
          profile: response.profiles.find { |e| e.id.to_s == item.owner_id.to_s }
        }
      end
    end

    def text item
      item['text']
    end

    def generate_uid item
      'vk' + item['from_id'].to_s + '_' + item['id'].to_s
    end

    def api_request query
      api.newsfeed.search(q: query, count: 200, extended: 1, fields: 'city,country')
    end

    def api
      @_api ||= VkontakteApi::Client.new(vk_account.access_token)
    end
end
