module RainbowPainter
  class HSL
    attr_reader :h, :s, :l

    class ColorError < StandardError; end

    DELTA = 1.0 / 255

    def initialize(h:, s:, l:)
      raise ColorError, 'Hue must be between 0 and 360' if h.negative? || h > 360

      raise ColorError, 'Saturation must be a fractional between 0 and 1' if s.negative? || s > 1.0

      raise ColorError, 'Luminance must be a fractional between 0 and 1' if l.negative? || l > 1.0

      @h = h.round.to_i
      @s = s.to_f
      @l = l.to_f
    end

    def hue
      @h
    end

    def hue=(value)
      self.h = value
    end

    def h=(value)
      value = value.to_i
      @h = if value > 360
             360
           elsif value.negative?
             0
           else
             value
           end
    end

    def saturation
      @s
    end

    def saturation=(value)
      self.s = value
    end

    def s=(value)
      @s = HSL.normalize(value)
    end

    def luminance
      @l
    end

    def luminance=(value)
      self.l = value
    end

    def l=(value)
      @l = HSL.normalize(value)
    end

    def ==(other)
      to_rgb == other
    end

    def to_rgb # rubocop:disable Metrics/AbcSize
      h = @h / 360.0

      return RGB.new(r: @l.to_f, g: @l.to_f, b: @l.to_f) if s.zero?

      q = @l < 0.5 ? @l * (1 + @s) : @l + @s - @l * @s
      p = 2 * @l - q
      r = hue_to_rgb(p, q, h + 1 / 3.0)
      g = hue_to_rgb(p, q, h)
      b = hue_to_rgb(p, q, h - 1 / 3.0)

      RGB.new(r: r, g: g, b: b)
    end

    def hex
      to_rgb.hex
    end

    def lighten_by(value)
      nl = value / 100.0
      @l = HSL.normalize(nl + @l)
      self
    end

    def darken_by(value)
      nl = value / 100.0
      @l = HSL.normalize(@l - nl)
      self
    end

    def hue_to_rgb(p, q, t)
      t += 1 if t.negative?
      t -= 1 if t > 1
      qp = q - p
      t_max = 2 / 3.0

      return (p + qp * 6 * t) if t < 1 / 6.0
      return q if t < 1 / 2.0
      return (p + qp * (t_max - t) * 6) if t < t_max

      p
    end

    def self.normalize(value)
      value = value.to_f
      return 1.0 if value > 1.0
      return 0.0 if value.negative?

      value
    end
  end
end
