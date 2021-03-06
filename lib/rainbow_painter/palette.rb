require 'json'

module RainbowPainter
  # Palette holds a set of colors
  class Palette # rubocop:disable Metric/ClassLength
    class FileNotFound < StandardError; end

    class InvalidType < StandardError; end

    attr_reader :custom

    TERMINAL_COLORS = %w[color0 color1 color2 color3 color4 color5 color6
                         color7 color8 color9 color10 color11 color12
                         color13 color14 color15 background foreground cursor].freeze

    SHADE_COLORS = %w[shade0 shade1 shade2 shade3 shade4].freeze

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

    def initialize(hash) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      TERMINAL_COLORS.each do |key|
        tc = hash.dig('colors', 'terminal', key)
        color = tc.nil? ? RGB.new(r: 0, g: 0, b: 0) : RGB.parse(tc)
        instance_variable_set("@#{key}", color)
      end

      @name = hash.dig('meta', 'name')
      @url = hash.dig('meta', 'url')
      @type = hash.dig('meta', 'type') || 'dark'
      @custom = {}

      color_steps = ColorSteps.new(background, foreground).steps(SHADE_COLORS.size)

      SHADE_COLORS.each_with_index do |shade, i|
        define_singleton_method(shade.to_sym) { color_steps[i] }
      end

      cus = hash.dig('colors', 'custom')

      return if cus.nil?

      cus.each do |col|
        c = RGB.parse(col['color'])
        c = c.lighten_by(col['lighten']) if col.include?('lighten')
        c = c.darken_by(col['darken']) if col.include?('darken')
        color_name = col['name']
        define_singleton_method(color_name.to_sym) { @custom[color_name] }
        @custom[color_name] = c
      end
    end

    def name
      @name || ''
    end

    def url
      @url || ''
    end

    def type
      @type || 'dark'
    end

    def dark?
      @type.to_s == 'dark'
    end

    def light?
      @type.to_s != 'dark'
    end

    def give_binding
      binding
    end

    def self.load(palette_basename)
      user_palette_path = File.join(OUTPUT_PATH, 'palettes', '*')
      palette_path = File.join(__dir__, '..', '..', 'palettes', '*')
      (Dir.glob(user_palette_path) + Dir.glob(palette_path)).each do |path|
        if palette_basename == File.basename(path)
          puts "LOADING #{path}"
          return load_path(path)
        end
      end
    end

    def self.load_path(filepath)
      raise FileNotFound, "File #{filepath} not found" unless File.exist?(filepath)

      case File.extname(filepath)
      when '.json'
        load_palette(File.read(filepath), JSON)
      else
        raise InvalidType, "File #{filepath} is not valid"
      end
    end

    def self.load_palette(string, klass)
      begin
        parsed_template = klass.parse(string)
      rescue => e
        puts "ERROR: #{klass} #{e.message}"
        exit 1
      end
      new(parsed_template)
    end

    def self.load_palette_json(string)
      load_palette(string, JSON)
    end
  end
end
