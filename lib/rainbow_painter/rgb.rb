module RainbowPainter
  # Handles RGB colors
  class RGB # rubocop:disable Metrics/ClassLength
    attr_reader :r, :g, :b

    DELTA = 1.0 / 255.0

    def initialize(r:, g:, b:)
      @r = r.is_a?(Integer) ? RGB.to_fractional(r) : r
      @g = g.is_a?(Integer) ? RGB.to_fractional(g) : g
      @b = b.is_a?(Integer) ? RGB.to_fractional(b) : b
    end

    def ==(other) # rubocop:disable Metrics/AbcSize
      other = other.to_rgb unless other.is_a?(RGB)
      (r - other.r).abs +
        (g - other.g).abs +
        (b - other.b).abs < 3.0 * DELTA
    end

    def to_s
      hex
    end

    def red_i
      (@r * 255).round
    end

    def red
      @r
    end

    def red=(red)
      self.r = red
    end

    def r=(red)
      @r = RGB.normalize(red)
    end

    def green
      @g
    end

    def green_i
      (@g * 255).round
    end

    def green=(green)
      self.g = green
    end

    def g=(green)
      @g = RGB.normalize(green)
    end

    def blue
      @b
    end

    def blue_i
      (@b * 255).round
    end

    def blue=(blue)
      self.b = blue
    end

    def b=(blue)
      @b = RGB.normalize(blue)
    end

    def hex
      r = (@r * 255).round
      r = 255 if r > 255

      g = (@g * 255).round
      g = 255 if g > 255

      b = (@b * 255).round
      b = 255 if b > 255

      format('#%<r>02x%<g>02x%<b>02x', { r: r, g: g, b: b })
    end

    def lighten_by(percent)
      to_hsl.lighten_by(percent).to_rgb
    end

    def darken_by(percent)
      to_hsl.darken_by(percent).to_rgb
    end

    def mix_with(mask, opacity) # rubocop:disable Metrics/AbcSize
      opacity /= 100.0
      rgb = dup

      fix_opacity = 1 - opacity

      rgb.r = ((@r * opacity) + (mask.r * fix_opacity)).round(3)
      rgb.g = ((@g * opacity) + (mask.g * fix_opacity)).round(3)
      rgb.b = ((@b * opacity) + (mask.b * fix_opacity)).round(3)

      rgb
    end

    def to_hsl # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      min   = [@r, @g, @b].min
      max   = [@r, @g, @b].max
      delta = (max - min).to_f

      lum   = (max + min) / 2.0

      if delta.zero?
        hue = 0
        sat = 0
      else
        sat = if (lum - 0.5).negative?
                delta / (max + min).to_f
              else
                delta / (2 - max - min).to_f
              end

        # This is based on the conversion algorithm from
        # http://en.wikipedia.org/wiki/HSV_color_space#Conversion_from_RGB_to_HSL_or_HSV
        # Contributed by Adam Johnson
        sixth = 1 / 6.0
        if @r == max
          hue = (sixth * ((@g - @b) / delta))
          hue += 1.0 if @g < @b
        elsif @g == max
          hue = (sixth * ((@b - @r) / delta)) + (1.0 / 3.0)
        elsif @b == max
          hue = (sixth * ((@r - @g) / delta)) + (2.0 / 3.0)
        end

        hue += 1 if hue.negative?
        hue -= 1 if hue > 1
      end
      HSL.new(h: hue * 360.0, s: sat, l: lum)
    end

    class << self
      def parse(string)
        return RGB.new(r: 0, g: 0, b: 0) if string.nil?

        string.chomp!
        if string[0] == '#'
          red, green, blue = from_hex(string)
          RGB.new(r: to_fractional(red), g: to_fractional(green), b: to_fractional(blue))
        elsif string[0..2] == 'rgb'
          red, green, blue = from_rgb(string)
          RGB.new(r: red, g: green, b: blue)
        end
      end

      def normalize_int(value)
        vi = value.to_i
        if vi.negative?
          0
        elsif vi > 255
          255
        else
          vi
        end
      end

      def to_fractional(value)
        (value / 255.0).round(3)
      end

      def from_rgb(string)
        match = /rgba?\(\s*([.%0-9]*)\s*,\s*([.%0-9]*)\s*,\s*([.%0-9]*)\s*\)/i.match(string)
        return [0, 0, 0] if match.nil?

        r = rgb_string_to_int(match[1])
        g = rgb_string_to_int(match[2])
        b = rgb_string_to_int(match[3])
        [r, g, b]
      end

      def rgb_string_to_int(value)
        value.chomp!
        if value[-1] == '%'
          ((value.to_i / 100.0) * 255.0).round
        elsif value =~ /\./
          (value.to_f * 255).round
        else
          value.to_i
        end
      end

      def from_hex(string)
        hex = string.scan(/[0-9a-f]/i)
        case hex.size
        when 3
          hex.map { |char| (char * 2).to_i(16) }
        when 6
          hex.each_slice(2).map { |char| char.join.to_i(16) }
        else
          raise ArgumentError, 'Not a supported HTML colour type.'
        end
      end

      def normalize(value)
        value = value.to_f
        return 1.0 if value > 1.0
        return 0.0 if value.negative?

        value
      end
    end
  end
end
