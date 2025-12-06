return {
  s(
    {
      name = "bundler/inline",
      trig = "bundler/inline",
    },
    {
      t({
        "require \"bundler/inline\"",
        "",
        "gemfile do",
        "  source \"https://gem.coop\"",
        "",
      }),
      t({ "", "  " }), i(0),
      t({ "", "end" }),
    }
  )
}
