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
      t({ "", "  gem \"" }), i(1, "debug"), t("\""),
      t({ "", "end" }),
    }
  )
}
