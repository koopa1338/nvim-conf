return {
  s(
    {
      trig = "tmod",
      name = "test mod",
      dscr = "create mod for tests",
    },
    fmt(
      [[
      #[cfg(test)]
      mod test {{
          use super::*;

          {}
      }}
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    "closure",
    fmt(
      [[
      {}|{}| {{
          {}
      }}{}
      ]],
      {
        c(1, {
          t "",
          t "move ",
        }),
        i(2),
        i(3),
        i(0),
      }
    )
  ),
  s(
    {
      trig = "structgen",
      name = "struct generic",
      dscr = "struct with generic",
    },
    fmt(
      [[
      struct {}<{}> {{
          {}
      }}
      ]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),
  s(
    {
      trig = "fnret",
      name = "fn with return type",
      dscr = "function that has a togglable return type",
    },
    fmt(
      [[
      {}fn {}({}){} {{
        {}
      }}
      ]],
      {
        c(1, {
          t "",
          t "pub ",
          t "pub(crate) ",
        }),
        i(2, "name"),
        i(3, "params"),
        c(4, {
          t "",
          sn(nil, { t " -> ", i(1, "ReturnType") }),
        }),
        i(0),
      }
    )
  ),
  s({
    trig = "sss",
    name = "send sync static",
    dscr = "Send Sync trait bounds + static lifetime",
  }, t "Send + Sync + 'static"),
  s({
    trig = "s",
    name = "send sync",
    dscr = "Send Sync trait bounds",
  }, t "Send + Sync"),
  s(
    {
      trig = "implgen",
      name = "impl generic",
      dscr = "impl block with generics",
    },
    fmt(
      [[
      impl<{}> {}<{}> {{
          {}
      }}
      ]],
      {
        i(1, "Generic Type"),
        i(2, "Type"),
        rep(1, "Generic Type"),
        i(0),
      }
    )
  ),
}
