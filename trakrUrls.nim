import strformat

proc darthsAndDroidsAddr*(id: int): string =
  return fmt"https://darthsanddroids.net/episodes/{id:04}.html"

