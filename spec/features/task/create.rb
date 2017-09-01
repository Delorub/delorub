feature 'Task creation' do
  scenario 'when guest creating a task', js: true do
    visit new_task_path
  end
end
