Config
  { font          = "-misc-fixed-*-*-*-*-12-*-*-*-*-*-*-*"
  , border        = NoBorder
  , position      = TopW L 100
  , lowerOnStart  = True
  , bgColor       = "#000"
  , fgColor       = "#ddd"
  , template      = "<fc=#555>></fc> %kbd% <fc=#555>|</fc> %time% <fc=#555>|</fc> %battery% <fc=#555>|</fc> %StdinReader%"
  , commands      =
    [ Run Kbd [("us", "<fc=#99f>US</fc>"), ("ru", "<fc=#f99>RU</fc>")]
    , Run Com "/bin/bash" ["-c", "~/.xmonad/xmobar/time.sh"] "time" 600
    , Run Battery ["-t", "<acstatus> <leftbar>",
                   "--", "-O", "<fc=#9f9>⚡</fc>", "-o", "<fc=#999>⚡</fc>",
                   "-f", "ADP0/online"] 600
    , Run StdinReader
    ]
  }
