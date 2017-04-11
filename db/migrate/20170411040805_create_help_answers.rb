class CreateHelpAnswers < ActiveRecord::Migration
  def change
    create_table :help_answers do |t|
      t.integer :help_category_id
      t.string :title
      t.text :content
      t.text :synonyms
      t.integer :position
    end
  end
end
