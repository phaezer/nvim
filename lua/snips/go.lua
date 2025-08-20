local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local p = ls.parser.parse_snippet

return {
  s({
    trig = 'co',
    name = 'Constant',
    dscr = 'Insert a constant',
  }, fmt([[const {key} = {val}]], { key = i(1, 'key'), val = i(2, 'val') })),

  s({
    trig = 'fpf',
    name = 'Formatted Print',
    dscr = 'Insert a formatted print statement',
  }, fmt([[fmt.Printf("%#v\\n", {val})]], { val = i(1, 'val') })),

  s(
    {
      trig = 'ife',
      name = 'If Err',
      dscr = 'Insert a basic if err not nil statement',
    },
    fmt(
      [[
        if err != nil {{
          {do_this}
        }}
      ]],
      { do_this = i(1, 'do') }
    )
  ),

  p(
    {
      trig = 'ifer',
      name = 'If Err return',
      dscr = 'Insert a basic if err not nil statement with log.Fatal',
    },
    [[
  if err != nil {
    return err
  }
  ]]
  ),

  p(
    {
      trig = 'ifel',
      name = 'If Err Log Fatal',
      dscr = 'Insert a basic if err not nil statement with log.Fatal',
    },
    [[
  if err != nil {
    log.Fatal(err)
  }
  ]]
  ),

  s({
    trig = 'ifew',
    name = 'If Err Wrapped',
    dscr = 'Insert a if err not nil statement with wrapped error',
  }, {
    t 'if err != nil {',
    t { '', '  return fmt.Errorf("failed to ' },
    i(1, 'message'),
    t ': %w", err)',
    t { '', '}' },
  }),

  p(
    { trig = 'ma', name = 'Main Package', dscr = 'Basic main package structure' },
    [[
  package main

  import "fmt"

  func main() {
    fmt.Printf("%+v\n", "...")
  }
  ]]
  ),
}
