require "text-adventure-commander/parser"
require "text-adventure-commander/lexer"

class TextAdventureCommander
  def initialize(commands)
    allowed_symbols = []
    commands.keys.map do |key|
      key.to_s.split("_").each do |part|
        allowed_symbols << part
      end
    end

    @allowed_symbols = allowed_symbols.uniq
    @parser = Parser.new(commands)
  end

  def print_available_commands
    options = []
    @parser.commands.each do |command, _|
      options << command.to_s.tr("_", " ").capitalize
    end

    "[Options: #{options.join(" | ")}]"
  end

  def get_command(command)
    @parser.commands[command.to_sym]
  end

  def get_commands_from(input)
    recognized_symbols = Lexer.get_recognized_symbols(@allowed_symbols, input)
    @parser.get_recognized_commands(recognized_symbols, input)
  end
end
