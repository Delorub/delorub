ActiveAdmin.register VisitorSession do
  permit_params :ip, :city

  decorate_with VisitorSessionDecorator

  filter :city, as: :select
  filter :created_at
  filter :source_and_identity,
    as: :select,
    collection: -> {
      @collection_before_scope \
        .limit(nil)
        .reorder(nil)
        .joins(:actions)
        .where(visitor_session_actions: { action_type: %w[utm_source yandex_direct] })
        .group('visitor_session_actions.action_type, visitor_session_actions.identity')
        .order('count DESC')
        .pluck(
          'COUNT(DISTINCT visitor_sessions.id) as count',
          'visitor_session_actions.action_type',
          'visitor_session_actions.identity'
        ).map do |e|
          [
            "#{I18n.t("enumerize.visitor_session_action.action_type.#{e[1]}")} #{e[2]} (#{e[0]})",
            "#{e[1]}##{e[2]}"
          ]
        end.to_h
    }

  controller do
    helper_method :statistics

    def statistics
      @statistics ||= VisitorSession::StatisticsService.new(collection_before_scope)
    end

    def scoped_collection
      VisitorSession::ActiveAdminQuery.new.perform
    end
  end

  index do
    selectable_column
    column :city
    column :first_source_type do |resource|
      unless resource.first_source.nil?
        b resource.first_source.action_type.text
        text_node resource.first_source.identity
      end
    end
    column :first_source_keyword do |resource|
      text_node resource.first_source.keyword unless resource.first_source.nil?
    end
    column :first_form_keyword do |resource|
      text_node resource.first_form.keyword unless resource.first_form.nil?
    end
    column :first_link_keyword do |resource|
      text_node resource.first_link.keyword unless resource.first_link.nil?
    end
    column :coming_soon_request
    actions
    panel 'Статистика' do
      render 'statistics', locals: { statistics: statistics }
    end
    panel 'Топ действий' do
      render 'top_links', locals: { statistics: statistics }
    end
  end

  show do
    attributes_table do
      row :ip
      row :city
      row :created_at
    end

    table_for visitor_session.actions.order('id DESC') do
      column :created_at do |visitor_session_action|
        link_to l(visitor_session_action.created_at, format: :long), admin_visitor_session_action_path(visitor_session_action)
      end
      tag_column :action_type
      column :identity
      column :keyword
      column :url do |visitor_session_action|
        if visitor_session_action.url
          link_to visitor_session_action.url.truncate(50), visitor_session_action.url
        end
      end
    end
  end
end
