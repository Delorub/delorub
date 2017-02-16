class Editor::ActiveAdmin::PagePolicy < EditorPolicy
  def show?
    granted? ||
      case record.name.downcase.to_sym
        when :dashboard then user.permission.editor_dashboard?
      end
  end
end
