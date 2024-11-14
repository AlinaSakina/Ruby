require_relative 'task_manager'
require 'rspec'
require 'fileutils'

RSpec.describe TaskManager do
  let(:file_path) { 'test_tasks.json' }
  let(:manager) { TaskManager.new }

  before do
    stub_const('TaskManager::FILE_PATH', file_path)

    FileUtils.rm_f(file_path)
  end

  it 'adds a task' do
    allow(manager).to receive(:gets).and_return('Test Task', '2024-01-01', 'no')
    expect { manager.add_task }.to change { manager.instance_variable_get(:@tasks).size }.by(1)
  end

  it 'deletes a task' do
    manager.instance_variable_set(:@tasks, [Task.new('Test Task', '2024-01-01')])
    allow(manager).to receive(:gets).and_return('1')
    expect { manager.delete_task }.to change { manager.instance_variable_get(:@tasks).size }.by(-1)
  end

  it 'edits a task' do
    manager.instance_variable_set(:@tasks, [Task.new('Old Task', '2024-01-01')])
    allow(manager).to receive(:gets).and_return('1', 'New Task', '2024-12-31', 'yes')
    manager.edit_task
    task = manager.instance_variable_get(:@tasks).first
    expect(task.title).to eq('New Task')
    expect(task.deadline.to_s).to eq('2024-12-31')
    expect(task.completed).to be true
  end

  it 'lists tasks filtered by completion status' do
    manager.instance_variable_set(:@tasks, [
      Task.new('Completed Task', '2024-01-01', true),
      Task.new('Pending Task', '2024-02-01', false)
    ])
    expect { manager.list_tasks(filter_by_status: true) }.to output(/Completed Task/).to_stdout
  end

  it 'lists tasks filtered by deadline' do
    manager.instance_variable_set(:@tasks, [
      Task.new('Task 1', '2024-01-01'),
      Task.new('Task 2', '2024-02-01')
    ])
    expect { manager.list_tasks(due_by_date: '2024-01-15') }.to output(/Task 1/).to_stdout
  end

  it 'filters tasks by status and deadline' do
    manager.instance_variable_set(:@tasks, [
      Task.new('Completed Task', '2024-01-01', true),
      Task.new('Pending Task', '2024-02-01', false)
    ])
    allow(manager).to receive(:gets).and_return('completed', '2024-01-15')
    expect { manager.filter_tasks }.to output(/Completed Task/).to_stdout
  end

  it 'saves tasks to file' do
    allow(manager).to receive(:gets).and_return('Test Task', '2024-01-01', 'no')
    manager.add_task
    expect(File).to exist(file_path)

    data = JSON.parse(File.read(file_path))
    expect(data.size).to eq(1)
    expect(data.first['title']).to eq('Test Task')
    expect(data.first['deadline']).to eq('2024-01-01')
    expect(data.first['completed']).to eq(false)
  end

  it 'loads tasks from file' do
    File.write(file_path, JSON.pretty_generate([{ 'title' => 'Loaded Task', 'deadline' => '2024-01-01', 'completed' => false }]))

    loaded_manager = TaskManager.new
    expect(loaded_manager.instance_variable_get(:@tasks).size).to eq(1)
    expect(loaded_manager.instance_variable_get(:@tasks).first.title).to eq('Loaded Task')
    expect(loaded_manager.instance_variable_get(:@tasks).first.deadline.to_s).to eq('2024-01-01')
    expect(loaded_manager.instance_variable_get(:@tasks).first.completed).to eq(false)
  end
end







