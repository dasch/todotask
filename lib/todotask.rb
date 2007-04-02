
require 'rake'
require 'rake/tasklib'

class ToDoTask < Rake::TaskLib
  attr_accessor :name

  attr_accessor :todo_files

  def initialize(name = :todo)
    @name = name
    @todo_files = FileList['lib/**/*.rb', 'test/**/*.rb']

    yield self if block_given?

    desc 'Generate a ToDo list from the source files'
    task @name do
      items = Hash.new

      @todo_files.each do |file|
        lineno = 0
        list = File.readlines(file).inject([]) do |list, line|
          lineno += 1
          next list unless line =~ /#\s*TODO:?\s+(.*)/i
          list << @@item.new(file, lineno, $1)
        end

        items[file] = list unless list.empty?
      end

      items.each do |file, list|
        puts "\n#{file}:"
        list.each do |item|
          puts " * %03d: %s" % [item.lineno, item.text]
        end
      end

      total = items.inject(0){|total, (file, list)| total + list.size }
      puts "\n\nToDo items: #{total}"
    end
  end

  @@item = Struct.new(:filename, :lineno, :text)
end
