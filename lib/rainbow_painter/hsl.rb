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
      v = value.to_i
      @h = if v > 360
             360
           elsif v.negative?
             0
           else
             v
           end
    end

    def saturation
      @s
    end

    def saturation=(value)
      @s = normalize(value)
    end

    def s=(value)
      @s = normalize(value)
    end

    def luminance
      @l
    end

    def luminance=(value)
      @l = normalize(value)
    end

    def l=(value)
      @l = normalize(value)
    end

    def ==(other)
      to_rgb == other
    end

    def to_rgb
      h = @h / 360.0

      r = 0.0
      g = 0.0
      b = 0.0

      if s.zero?
        r = @l.to_f
        g = @l.to_f
        b = @l.to_f # achromatic
      else
        q = @l < 0.5 ? @l * (1 + @s) : @l + @s - @l * @s
        p = 2 * @l - q
        r = hue_to_rgb(p, q, h + 1 / 3.0)
        g = hue_to_rgb(p, q, h)
        b = hue_to_rgb(p, q, h - 1 / 3.0)
      end

      RGB.new(r: r, g: g, b: b)
    end

    def hex
      to_rgb.hex
    end

    def lighten_by(value)
      nl = value / 100.0
      @l = normalize(nl + @l)
      self
    end

    def darken_by(value)
      nl = value / 100.0
      @l = normalize(@l - nl)
      self
    end

    def hue_to_rgb(p, q, t)
      t += 1 if t.negative?
      t -= 1 if t > 1

      return (p + (q - p) * 6 * t) if t < 1 / 6.0
      return q if t < 1 / 2.0
      return (p + (q - p) * (2 / 3.0 - t) * 6) if t < 2 / 3.0

      p
    end

    def normalize(value)
      v = value.to_f
      return 1.0 if value > 1.0
      return 0.0 if value.negative?

      v
    end
  end
end
