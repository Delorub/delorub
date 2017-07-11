class AddTimestampsToHelpQuestions < ActiveRecord::Migration[4.2]
  def change
    add_timestamps(:help_questions)
    add_column(:help_questions, :replied_at, :datetime)
  end
end
