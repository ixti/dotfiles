function! AirlineThemePatch(palette)
  if g:airline_theme == 'jellybeans'
    for colors in values(a:palette.inactive)
      let colors[3] = 232
    endfor

    let a:palette.normal.airline_c[3]   = 232
    let a:palette.normal.airline_x[3]   = 232
    let a:palette.insert.airline_c[3]   = 232
    let a:palette.insert.airline_x[3]   = 232
    let a:palette.replace.airline_c[3]  = 232
    let a:palette.replace.airline_x[3]  = 232
    let a:palette.visual.airline_c[3]   = 232
    let a:palette.visual.airline_x[3]   = 232
  endif
endfunction
