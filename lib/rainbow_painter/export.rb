module RainbowPainter
  class Export
    def initialize(palette:)
      @palette = palette
    end

    def all
      rendered = []
      (user_template_paths + template_paths).each do |path|
        path_basename = File.basename(path)
        next if rendered.include?(path_basename)

        output = Template.new(palette: @palette, template_path: path).render
        output_path = File.join(RainbowPainter::CACHE_PATH, path_basename)
        puts "Exporting #{@palette.name} to #{output_path}"
        write(output, output_path)
        rendered << path_basename
      end
    end

    def write(output, target)
      fd = IO.sysopen(target, 'w')
      io = IO.new(fd)
      io.puts output
      io.close
    end

    def user_template_paths
      path = File.expand_path(File.join(RainbowPainter::OUTPUT_PATH, 'templates'))
      Dir.glob("#{path}/*")
    end

    def template_paths
      path = File.expand_path('templates')
      Dir.glob("#{path}/*")
    end

    def reload
      reload_kitty
      reload_xrdb
      reload_polybar
      reload_i3wm
    end

    def reload_kitty
      `kitty @ set-colors --all ~/.cache/rainbow-painter/colors-kitty.conf`
    end

    def reload_xrdb
      `xrdb -merge -quiet ~/.cache/rainbow-painter/colors.Xresources`
    end

    def reload_polybar
      `pkill -USR1 polybar`
    end

    def reload_i3wm
      `i3-msg reload`
    end
  end
end
