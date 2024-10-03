require 'securerandom'
require 'time'

class Originator
  attr_accessor :state

  def initialize(state)
    @state = state
    puts "Originator: Мій початковий стан: #{@state}"
  end

  def do_something_critical
    puts "Originator: Змінюю стан."
    @state = generate_random_string
    puts "Originator: і мій стан змінився на: #{@state}"
  end

  def create_checkpoint
    Checkpoint.new(@state)
  end

  def restore(checkpoint)
    @state = checkpoint.state
    puts "Originator: Мій стан було відновлено до: #{@state}"
  end

  private

  def generate_random_string
    SecureRandom.hex(16)
  end

  class Checkpoint
    attr_reader :state, :date

    def initialize(state)
      @state = state
      @date = Time.now
    end

    def get_label
      "#{@date.strftime('%Y-%m-%d %H:%M:%S')} / (#{@state[0, 10]}...)"
    end
  end
end

class Caretaker
  def initialize(originator)
    @originator = originator
    @checkpoints = []
  end

  def save_checkpoint
    puts "Caretaker: Зберігаю стан Originator"
    @checkpoints << @originator.create_checkpoint
  end

  def rollback
    return if @checkpoints.empty?

    checkpoint = @checkpoints.pop
    puts "Caretaker: Відновлення стану до: #{checkpoint.get_label}"
    @originator.restore(checkpoint)
  end

  def show_checkpoints
    puts "Caretaker: Список контрольних точок:"
    @checkpoints.each { |checkpoint| puts checkpoint.get_label }
  end
end

originator = Originator.new('Початковий стан')
caretaker = Caretaker.new(originator)

caretaker.save_checkpoint
originator.do_something_critical

caretaker.save_checkpoint
originator.do_something_critical

caretaker.save_checkpoint
originator.do_something_critical

caretaker.show_checkpoints

puts "\nКлієнт: Повертаємося до попереднього стану"
caretaker.rollback

puts "\nКлієнт: Ще раз"
caretaker.rollback
