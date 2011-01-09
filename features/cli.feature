Feature: Listing TODO items
  In order to know what's left to do in my project
  As a Ruby developer
  I want to extract and see the remaining TODO's from the source code

  Background:
    Given a file named "Rakefile" with:
      """
      require '../../lib/todotask'
      ToDoTask.new
      """

  Scenario: Getting help for the Rake task
    When I run "rake -T"
    Then the output should contain "rake todo"
    And the output should contain "# Generate a ToDo list from the source files"

  Scenario: No remaining TODO's
    Given a file named "lib/monkey.rb" with:
      """
      class Monkey
        def drink_beer
          puts "barf!"
        end
      end
      """
    When I run "rake todo"
    Then the output should contain:
      """
      ToDo items: 0
      """

  Scenario: A few TODO's in a single file
    Given a file named "lib/monkey.rb" with:
      """
      class Monkey
        # TODO: Make this lazy monkey do something!
        # TODO: Also, can we make it dance?
      end
      """
    When I run "rake todo"
    Then the output should contain:
      """
      lib/monkey.rb:
       * 002: Make this lazy monkey do something!
       * 003: Also, can we make it dance?


      ToDo items: 2
      """
