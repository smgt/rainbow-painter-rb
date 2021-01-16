# Shell variables
# Generated by 'rainbow-themer'

# Special
background='{{.Background}}'
foreground='{{.Foreground}}'
cursor='{{.Cursor}}'

# Colors
color0='{{.Color0}}'
color1='{{.Color1}}'
color2='{{.Color2}}'
color3='{{.Color3}}'
color4='{{.Color4}}'
color5='{{.Color5}}'
color6='{{.Color6}}'
color7='{{.Color7}}'
color8='{{.Color8}}'
color9='{{.Color9}}'
color10='{{.Color10}}'
color11='{{.Color11}}'
color12='{{.Color12}}'
color13='{{.Color13}}'
color14='{{.Color14}}'
color15='{{.Color15}}'

# FZF colors
export FZF_DEFAULT_OPTS="
    $FZF_DEFAULT_OPTS
    --color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
    --color info:7,prompt:2,spinner:1,pointer:232,marker:1
"

# Fix LS_COLORS being unreadable.
export LS_COLORS="${ {LS_COLORS} }:su=30;41:ow=30;42:st=30;44:"