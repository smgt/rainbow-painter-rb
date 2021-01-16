require 'erb'
module RainbowPainter
  # Load and renders a template for a palette
  class Template
    attr_reader :path, :palette

    # When a template isn't present
    class FileNotFound < StandardError; end

    def initialize(palette:, template_path:)
      @path = template_path
      @palette = palette
      @template = nil
      load_path
    end

    def load_path
      raise FileNotFound, "File #{@path} not found" unless File.exist?(@path)

      @template = ERB.new(File.read(@path), trim_mode: '%-')
      @template.filename = @path
      @template
    end

    def render
      @template.result(palette.give_binding)
    end
  end
end
