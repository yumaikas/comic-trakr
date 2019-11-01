import sugar, strutils, strformat
import htmlgen, markdown
import appConfig

proc css*(): string =
  # TODO: make this select from a list of themes, or pull from the database
  var back_color = "#191e2a"
  var fore_color = "#21EF9F"
  var link_color = "aqua"
  var visted_color = "darkcyan"
  if THEME == "AQUA":
    discard
  elif THEME == "AUTUMN":
    back_color = "#2a2319"
    fore_color = "#EFC121"
    link_color = "F0FF00"
    visted_color = "#a5622a"
  # Right now, the implicit default theme is AQUA, if we don't recognize the current theme.
    

  return style(&"""
body {{
  width: 100%;
}}
iframe {{
  width: 100%;
  min-height: 800px;
  overflow: visible;
}}
body,input,textarea {{
  font-family: Iosevka, monospace;
  background: {back_color};
  color: {fore_color};
}}
td {{ margin: 5px; }}
a {{ color: {link_color}; font-size: 2em; margin: 30px; }}
a:visited {{ color: {visted_color}; }}
""")


proc pageBase(inner: string): string =
  return "<!DOCTYPE html>" & html(
    head(
      meta(charset="utf-8"),
      meta(name="viewport", content="width=device-width, initial-scale=1.0"),
    ),
    body(
      css(),
      inner
    )
  )

proc tableWith(inner: () -> string): string =
  var output = newSeq[string]()
  output.add("<table>")
  output.add(inner())
  output.add("</table>")
  return output.join("\n")

proc errorPage*(message: string): string =
  return pageBase(message)

proc frameForAddr*(address: string): string =
  return pageBase(`div`(
    a(href="/dec", "Back"),
    a(href="/inc", "Forward"),
    iframe(src=address),
    a(href="/dec", "Back"),
    a(href="/inc", "Forward")
  ))
