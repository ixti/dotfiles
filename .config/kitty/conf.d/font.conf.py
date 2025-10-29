#!/usr/bin/env python

from kitty.fonts.common import all_fonts_map

MONO_LISA_VARIABLE = """
font_family      family="MonoLisa Variable" variable_name=MonoLisaVariableRegular features="ss02 ss03 ss06 ss07 ss08 ss09 ss11 ss16 -calt -liga" wght=180
font_size        11
bold_font        auto
italic_font      auto
bold_italic_font auto
"""

VICTOR_MONO = """
font_family       Victor Mono
font_size         12
bold_font         auto
italic_font       auto
bold_italic_font  auto
disable_ligatures cursor
"""

try:
    family_map = all_fonts_map().get("family_map", {})
    familie    = set(map(str.lower, family_map.keys()))

    if "monolisa variable" in families:
        print(MONO_LISA_VARIABLE)
    else:
        print(VICTOR_MONO)
except:
    pass
