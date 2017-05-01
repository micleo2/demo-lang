require "treetop"
require_relative "simptoy"

Treetop.load "my_grammar"
intr = SimpToy::Interpreter.new "code-samples/code.txt"
intr.run
