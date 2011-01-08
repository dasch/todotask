describe ToDoTask do
  let :klass do
    ToDoTask
  end

  describe 'in project with todos,' do
    let :project_dir do
      File.expand_path("#{File.dirname __FILE__}/../fixtures/project_with_todos")
    end

    describe "when 'rake --tasks' is executed," do
      before :each do
        Dir.chdir project_dir do
          `rake --tasks > #{stdout_filename}`
          `rake --tasks > #{stdout_stderr_filename} 2>&1`
        end
      end

      let :expected_stdout_stderr do
        <<-end_expected_stdout_stderr
(in #{project_dir})
rake todo  # Generate a ToDo list from the source files
        end_expected_stdout_stderr
      end

      let :stdout_filename do
        'rake-tasks.out'
      end

      let :stdout_stderr_filename do
        'rake-tasks.outerr'
      end

      describe 'stdout' do
        subject { File.read "#{project_dir}/#{stdout_filename}" }

        it { should == expected_stdout_stderr }
      end

      describe 'combined stdout and stderr' do
        subject { File.read "#{project_dir}/#{stdout_stderr_filename}" }

        it { should == expected_stdout_stderr }
      end
    end

    describe "when 'rake todo' is executed," do
      before :each do
        Dir.chdir project_dir do
          `rake todo > #{stdout_filename}`
          `rake todo > #{stdout_stderr_filename} 2>&1`
        end
      end

      let :expected_stdout_stderr do
        <<-end_expected_stdout_stderr
(in #{project_dir})

lib/wopr/games/global_thermonuclear_war.rb:
 * 003: Wouldn't we prefer a nice game of chess?
 * 005: Add backdoor killswitch in case Falken is unavailable


ToDo items: 2
        end_expected_stdout_stderr
      end

      let :stdout_filename do
        'rake-todo.out'
      end

      let :stdout_stderr_filename do
        'rake-todo.outerr'
      end

      describe 'stdout' do
        subject { File.read "#{project_dir}/#{stdout_filename}" }

        it { should == expected_stdout_stderr }
      end

      describe 'combined stdout and stderr' do
        subject { File.read "#{project_dir}/#{stdout_stderr_filename}" }

        it { should == expected_stdout_stderr }
      end
    end
  end
end
