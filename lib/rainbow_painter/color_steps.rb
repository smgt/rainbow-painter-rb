module RainbowPainter
  class ColorSteps
    def initialize(color1, color2)
      @color1 = color1
      @color2 = color2
    end

    def steps(count)
      count.times.to_a.map do |step|
        s = step.to_f + 1.0
        RGB.new(
          r: delta(@color1.red, @color2.red, count) * s,
          g: delta(@color1.green, @color2.green, count) * s,
          b: delta(@color1.blue, @color2.blue, count) * s
        )
      end
    end

    def delta(channel1, channel2, count)
      (channel2 - channel1) / (count.to_f + 1.0)
    end
  end
end
