class VisitorSession::StatisticsService
  attr_reader :scope

  STATUS_VALUES = [
    :count, :coming_soon_pages, :coming_soon_pages_rate, :coming_soon_requests,
    :coming_soon_requests, :coming_soon_requests_rate
  ].freeze

  def initialize scope
    @scope = scope.limit(nil).reorder(nil)
    @count = nil
  end

  def perform
    STATUS_VALUES.map { |e| [e, send(e)] }.to_h
  end

  def count
    @count ||= scope.count
  end

  def coming_soon_pages
    scope \
      .joins(%(
        INNER JOIN "visitor_session_actions" AS "visitor_session_actions_statistics"
        ON "visitor_session_actions_statistics"."visitor_session_id" = "visitor_sessions"."id"
      ))
      .where(visitor_session_actions_statistics: { action_type: %w[internal_link post_form] })
      .group(:id).count.count
  end

  def coming_soon_pages_rate
    rate_for coming_soon_pages
  end

  def coming_soon_requests
    scope \
      .joins(:coming_soon_requests)
      .group(:id).count.count
  end

  def coming_soon_requests_rate
    rate_for coming_soon_requests
  end

  def top_links
    VisitorSession
      .joins(:actions)
      .where(id: scope)
      .where(visitor_session_actions: { action_type: %w[internal_link post_form] })
      .group('visitor_session_actions.keyword, visitor_session_actions.identity, visitor_session_actions.action_type')
      .order('count DESC')
      .limit(10)
      .pluck(
        'COUNT(visitor_sessions.id) as count',
        'visitor_session_actions.keyword',
        'visitor_session_actions.identity',
        'visitor_session_actions.action_type'
      )
      .map { |e| format_top_link_keyword e }
  end

  private

    def rate_for value
      return '0%' if value.zero?
      ((value / count.to_f) * 100).round(2).to_s + ' %'
    end

    def format_top_link_keyword value
      identity = " (#{value[2]})" unless value[2].nil?
      [value[3], value[0], "#{value[1]}#{identity}"]
    end
end
