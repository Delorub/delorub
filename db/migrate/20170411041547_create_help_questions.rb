class CreateHelpQuestions < ActiveRecord::Migration[4.2]
  def change
    create_table :help_questions do |t|
      t.string :name
      t.string :email
      t.text :content
      t.text :reply
      t.boolean :answered, default: false
    end
  end
end
