module RainbowPainter
  class Export
    TEMPLATES = %w[
      colors
      colors.sh
      colors-kitty.conf
      colors.Xresources
      colors.polybar
      colors-rofi-dark.rasi
      colors-i3.conf
    ].freeze

    def initialize(palette:)
      @palette = palette
    end

    def all
      TEMPLATES.each do |path|
        output = Template.new(palette: @palette, template_path: File.join('templates', path)).render
        output_path = File.join(OUTPUT_PATH, path)
        File.open(output_path, 'w') do |fp|
          fp.write(output)
        end
      end
    end

    def reload
      reload_kitty
      reload_xrdb
      reload_polybar
      reload_i3wm
    end

    def reload_kitty
      `kitty @ set-colors --all tmp/colors-kitty.conf`
    end

    def reload_xrdb
      `xrdb -merge -quiet tmp/colors.Xresources`
    end

    def reload_polybar
      `pkill -USR1 polybar`
    end

    def reload_i3wm
      `i3-msg reload`
    end
  end
end
