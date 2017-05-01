require "treetop"
Treetop.load "my_grammar"

module SimpToy
  class Interpreter
    attr_reader :code
    attr_accessor :data, :pc, :should_stop

    def initialize filepath=nil
      @code = Array.new
      if filepath
        IO.foreach(filepath) do |line|
          @code << line.split("//", 2)[0].strip # seperate the comment from the code
        end
      end

      @data = Array.new
      @pc = 0
    end

    def run
      @parser = MyGrammarParser.new
      @pc = 0
      loop do
        instruction = @code[@pc]  # fetch
        @pc += 1                  # increment
        node = @parser.parse(instruction)
        node.execute(self) if node.respond_to? :execute
        break if @should_stop
      end
    end
  end
end
