meta {
    name = "Sonokai"
    url = "https://github.com/sainnhe/sonokai/"
}

colors {
    terminal {
        primary {
            background = "#2c2e34"
            foreground = "#e2e2e3"
            cursor = "#a6a6a6"
        }
        normal {
            black = "#181819" # color0
            red = "#fc5d7c" # color1
            green = "#9ed072" # color2
            yellow = "#e7c664" # color 3
            blue = "#76cce0" # color 4
            magenta = "#b39df3" # color 5
            cyan = "#f39660" # color 6
            white = "#e2e2e3" # color 7
        }
        bright {
            black = "#181819" # color 8
            red = "#xfc5d7c" # color 9
            green = "#9ed072" # color 10
            yellow = "#e7c664" # color 11
            blue = "#76cce0" # color 12
            magenta = "#b39df3" # color 13
            cyan = "#f39660" # color 14
            white = "#e2e2e3" # color 15
        }
    }
    custom {
        blend "bgfg" {
            first = "#2c2e43"
            second = "#e2e2e3"
            steps =  10
        }
        color "redish" {
            hex "#ff0000"
        }

        color "bluish" {
            hsl {
                h = 237
                s = 0.30
                l = 0.24
            }
        }
    }
}
