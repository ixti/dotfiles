Config
  { font          = "-misc-fixed-*-*-*-*-12-*-*-*-*-*-*-*"
  , border        = NoBorder
  , position      = TopW L 100
  , lowerOnStart  = True
  , bgColor       = "#000"
  , fgColor       = "#ddd"
  , template      = "<fc=#555>></fc> %kbd% <fc=#555>|</fc> %time% <fc=#555>|</fc> %coretemp% <fc=#555>|</fc> %battery% <fc=#555>|</fc> %StdinReader%"
  , commands      =
    [ Run Kbd                 [ ("us" , "<fc=#99f>US</fc>")
                              , ("ru" , "<fc=#f99>RU</fc>")
                              ]
    , Run Battery             [ "--template"  , "<acstatus> <leftbar>"
                              , "--Low"       , "10" -- units: %
                              , "--High"      , "80" -- units: %
                              , "--"
                              , "-O"          , "<fc=darkgreen>+</fc>"
                              , "-o"          , "<fc=darkred>-</fc>"
                              , "-i"          , "<fc=#777>=</fc>"
                              , "-f"          , "ADP0/online"
                              ] 600
    , Run CoreTemp            [ "--template" , "<core0><fc=#333>|</fc><core1>"
                              , "--Low"      , "70" -- units: °C
                              , "--High"     , "80" -- units: °C
                              , "--low"      , "#777"
                              , "--normal"   , "darkgreen"
                              , "--high"     , "darkred"
                              ] 50
    , Run Com "/bin/bash"     [ "-c"         , "~/.xmonad/xmobar/time.sh"
                              ] "time" 600
    , Run StdinReader
    ]
  }
