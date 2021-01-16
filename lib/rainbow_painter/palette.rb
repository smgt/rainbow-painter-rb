require 'json'
require 'rhcl'

module RainbowPainter
  # Palette holds a set of colors
  class Palette
    class FileNotFound < StandardError; end

    class InvalidType < StandardError; end

    TERMINAL_COLORS = %w[color0 color1 color2 color3 color4 color5 color6
      color7 color8 color9 color10 color11 color12
      color13 color14 color15 background foreground cursor].freeze

    TERMINAL_COLORS_ALIAS = {
      'color0' => ['black'],
      'color8' => ['bright_black'],
      'color1' => ['red'],
      'color9' => ['bright_red'],
      'color2' => ['green'],
      'color10' => ['bright_green'],
      'color3' => ['yellow'],
      'color11' => ['bright_yellow'],
      'color4' => ['blue'],
      'color12' => ['bright_blue'],
      'color5' => ['magenta'],
      'color13' => ['bright_magenta'],
      'color6' => ['cyan'],
      'color14' => ['bright_cyan'],
      'color7' => ['white'],
      'color15' => ['bright_white']
    }.freeze

    TERMINAL_COLORS.each do |key|
      define_method(key.to_sym) do
        instance_variable_get("@#{key}")
      end
    end

    TERMINAL_COLORS_ALIAS.each do |color, aliases|
      aliases.each do |a|
        define_method(a.to_sym) do
          instance_variable_get("@#{color}")
        end
      end
    end

    def initialize(hash)
      TERMINAL_COLORS.each do |key|
        tc = hash['colors']['terminal']
        instance_variable_set("@#{key}", RGB.parse(tc[key]))
      end

      @name = hash.dig('meta', 'name')
      @url = hash.dig('meta', 'url')
      @custom = {}
      hash.dig('colors', 'custom').each do |col|
        c = RGB.parse(col['color'])
        c = c.lighten_by(col['lighten']) if col.include?('lighten')
        c = c.darken_by(col['darken']) if col.include?('darken')
        define_singleton_method(col['name'].to_sym) { @custom[col['name']] }
        @custom[col['name']] = c
      end
    end

    def name
      @name || ''
    end

    def url
      @url || ''
    end

    def custom
      @custom
    end

    def get_binding
      binding
    end

    def self.load_path(filepath)
      raise FileNotFound, "File #{filepath} not found" unless File.exist?(filepath)
      case File.extname(filepath)
      when '.hcl'
        load_palette(File.read(filepath), Rhcl)
      when '.json'
        load_palette(File.read(filepath), JSON)
      else
        raise InvalidType, "File #{filepath} is not valid"
      end
    end

    def self.load_palette(string, klass)
      begin
        p = klass.parse(string)
      rescue => e
        puts "ERROR: #{klass.tos} #{e.message}"
        exit 1
      end
      self.new(p)
    end

    def self.load_palette_json(string)
      load_palette(string, JSON)
    end

    def self.load_palette_hcl(string)
      load_palette(string, Rhcl)
    end
  end
end
