class AddTimestampsToHelpQuestions < ActiveRecord::Migration
  def change
    add_timestamps(:help_questions)
    add_column(:help_questions, :replied_at, :datetime)
  end
end
