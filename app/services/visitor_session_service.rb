class VisitorSessionService
  attr_reader :request, :session, :cookies

  COOKIE_LAST_LINK_TITLE_KEY = 'session_last_link_title'.freeze
  COOKIE_LAST_LINK_ID_KEY = 'session_last_link_id'.freeze

  def initialize request, session, cookies
    @request = request
    @session = session
    @cookies = cookies
    @model = nil
  end

  def perform
    return if no_session?
    model
    cookies[:no_visitor_session] = true if model.city.nil?
    check_referers
    check_forms
    check_internal_link
    check_utm
    return if model.actions.length.zero?
    model.save
    cookies.permanent.encrypted[:visitor_session_id] = model.id
  end

  def add_action attributes
    model.actions.build action_default_attributes.merge(attributes)
  end

  def model
    @model ||= VisitorSession.find_or_initialize_by(id: cookies.permanent.encrypted[:visitor_session_id]) do |visitor_session|
      visitor_session.ip = request.ip
      visitor_session.city = Ipgeobase.lookup(request.ip).city
    end
  end

  def no_session?
    cookies[:no_visitor_session].present?
  end

  private

    def action_default_attributes
      { url: request.url }
    end

    def last_link_id
      return if cookies[COOKIE_LAST_LINK_ID_KEY].in? ['undefined', 'null', '', nil]
      cookies[COOKIE_LAST_LINK_ID_KEY].strip
    end

    def last_link_title
      return if cookies[COOKIE_LAST_LINK_TITLE_KEY].in? ['undefined', 'null', '', nil]
      cookies[COOKIE_LAST_LINK_TITLE_KEY].strip
    end

    def check_internal_link
      return if last_link_id.nil? && last_link_title.nil?
      add_action(
        action_type: :internal_link,
        identity: last_link_id,
        keyword: last_link_title,
        url: request.referer
      )
    end

    def check_yandex_direct_referer
      return unless URI(request.referer).host == 'yabs.yandex.ru'
      params = Rack::Utils.parse_query URI(request.referer).query
      return if params['q'].nil?
      add_action(
        action_type: :yandex_direct,
        keyword: params['q'],
        data: params
      )
      true
    end

    def check_referers
      return if request.referer.blank?
      return if URI(request.url).host == URI(request.referer).host
      return if check_yandex_direct_referer
      add_action(
        action_type: :global_referer,
        keyword: request.referer
      )
    end

    def check_forms
      return unless request.post?
      return if request.params[:form_identity].blank?
      add_action(
        action_type: :post_form,
        identity: request.params[:form_identity],
        keyword: request.params[request.params[:form_keyword_field]],
        data: request.params,
        url: request.referer
      )
    end

    def check_utm
      return unless request.get?
      return if request.params[:utm_source].blank?
      add_action(
        action_type: :utm_source,
        identity: request.params[:utm_source],
        keyword: request.params[:utm_term],
        data: request.params
      )
    end
end
