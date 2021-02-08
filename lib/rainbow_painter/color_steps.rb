module RainbowPainter
  # Blends two colors and returns n variants
  class ColorSteps
    def initialize(color_from, color_to)
      @color_from = color_from
      @color_to = color_to
    end

    def steps(count) # rubocop:disable Metrics/AbcSize
      count.times.to_a.map do |step|
        s = step.to_f + 1.0
        RGB.new(
          r: delta(@color_from.red, @color_to.red, count) * s,
          g: delta(@color_from.green, @color_to.green, count) * s,
          b: delta(@color_from.blue, @color_to.blue, count) * s
        )
      end
    end

    def delta(channel_from, channel_to, count)
      (channel_to - channel_from) / (count.to_f + 1.0)
    end
  end
end
