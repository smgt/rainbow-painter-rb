require 'erb'
module RainbowPainter
  class Template
    attr_reader :path, :palette
    class FileNotFound < StandardError; end
    def initialize(palette:, template_path:)
      @path = template_path
      @palette = palette
      load_path
    end

    def load_path
      raise FileNotFound, "File #{@path} not found" unless File.exist?(@path)
      @template = ERB.new(File.read(@path), trim_mode: "%-")
      @template.filename = @path
      @template
    end

    def render
      @template.result(palette.get_binding)
    end
  end
end
