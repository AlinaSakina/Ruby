require 'json'
require 'date'

class Task
  attr_accessor :title, :deadline, :completed

  def initialize(title, deadline, completed = false)
    @title = title
    @deadline = Date.parse(deadline)
    @completed = completed
  end

  def to_hash
    {
      title: @title,
      deadline: @deadline.to_s,
      completed: @completed
    }
  end
end

class TaskManager
  FILE_PATH = 'tasks.json'

  def initialize
    @tasks = load_tasks
  end

  def add_task
    puts "Enter task title:"
    title = gets.chomp
    puts "Enter deadline (YYYY-MM-DD):"
    deadline = gets.chomp
    puts "Is the task completed? (yes/no):"
    completed = gets.chomp.downcase == 'yes'

    @tasks << Task.new(title, deadline, completed)
    save_tasks
    puts "Task added successfully!"
  end

  def delete_task
    list_tasks
    puts "Enter the number of the task to delete:"
    index = gets.to_i - 1
    if valid_index?(index)
      @tasks.delete_at(index)
      save_tasks
      puts "Task deleted successfully!"
    else
      puts "Invalid task number!"
    end
  end

  def edit_task
    list_tasks
    puts "Enter the number of the task to edit:"
    index = gets.to_i - 1
    if valid_index?(index)
      puts "Enter new title (leave blank to keep current):"
      new_title = gets.chomp
      puts "Enter new deadline (YYYY-MM-DD, leave blank to keep current):"
      new_deadline = gets.chomp
      puts "Is the task completed? (yes/no):"
      completed = gets.chomp.downcase == 'yes'

      task = @tasks[index]
      task.title = new_title unless new_title.empty?
      task.deadline = Date.parse(new_deadline) unless new_deadline.empty?
      task.completed = completed
      save_tasks
      puts "Task updated successfully!"
    else
      puts "Invalid task number!"
    end
  end

  def list_tasks(filter_by_status: nil, due_by_date: nil)
    tasks_to_display = @tasks
    tasks_to_display = tasks_to_display.select { |task| task.completed == filter_by_status } unless filter_by_status.nil?
    tasks_to_display = tasks_to_display.select { |task| task.deadline <= Date.parse(due_by_date) } if due_by_date

    tasks_to_display.each_with_index do |task, index|
      status = task.completed ? "Completed" : "Pending"
      puts "#{index + 1}. #{task.title} - Due: #{task.deadline} - Status: #{status}"
    end
  end

  def filter_tasks
    puts "Filter by status? (completed/pending):"
    status = gets.chomp.downcase == 'completed'
    puts "Filter by deadline? (Enter date YYYY-MM-DD or leave blank):"
    due_by_date = gets.chomp
    list_tasks(filter_by_status: status, due_by_date: due_by_date.empty? ? nil : due_by_date)
  end

  private

  def load_tasks
    if File.exist?(FILE_PATH)
      JSON.parse(File.read(FILE_PATH)).map do |task_data|
        Task.new(task_data['title'], task_data['deadline'], task_data['completed'])
      end
    else
      []
    end
  end

  def save_tasks
    File.write(FILE_PATH, JSON.pretty_generate(@tasks.map(&:to_hash)))
  end

  def valid_index?(index)
    index >= 0 && index < @tasks.size
  end
end

def menu
  manager = TaskManager.new
  loop do
    puts "\nTask Manager Menu:"
    puts "1. Add Task"
    puts "2. Delete Task"
    puts "3. Edit Task"
    puts "4. List Tasks"
    puts "5. Filter Tasks"
    puts "6. Exit"
    print "Choose an option: "
    choice = gets.chomp.to_i

    case choice
    when 1
      manager.add_task
    when 2
      manager.delete_task
    when 3
      manager.edit_task
    when 4
      manager.list_tasks
    when 5
      manager.filter_tasks
    when 6
      break
    else
      puts "Invalid option. Please try again."
    end
  end
end

menu if __FILE__ == $PROGRAM_NAME



