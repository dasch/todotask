require 'rake/tasklib'

class ToDoTask < Rake::TaskLib
  attr_accessor :name

  attr_accessor :todo_files

  attr_accessor :annotations

  def initialize(name = :todo)
    @name = name
    @todo_files = FileList['lib/**/*.rb', 'test/**/*.rb']
    @annotations = %w(TODO FIXME)

    yield self if block_given?

    desc 'Generate a ToDo list from the source files'
    task @name do
      items = Hash.new

      @todo_files.each do |file|
        lineno = 0
        list = File.readlines(file).inject([]) do |list, line|
          lineno += 1
          next list unless line =~ /#\s*(#{@annotations.join('|')}):?\s+(.*)/i
          list << @@item.new(file, lineno, $1, $2)
        end

        items[file] = list unless list.empty?
      end

      items.each do |file, list|
        puts "\n#{file}:"

        annotation_types = list.map {|i| i.annotation }.uniq

        # The size of the annotation type field, including the ":"
        field_size = annotation_types.map {|a| a.length }.max + 1

        list.each do |item|
          puts " * %- *s %s (line %d)" % [field_size, item.annotation + ":", item.text, item.lineno]
        end
      end

      total = items.inject(0){|total, (file, list)| total + list.size }
      puts "\nToDo items: #{total}"
    end
  end

  @@item = Struct.new(:filename, :lineno, :annotation, :text)
end
