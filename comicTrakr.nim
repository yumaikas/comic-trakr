import strformat, strutils
import jester
import appConfig, views
from nativesockets import Port

var bindAddr = "localhost"
if not BIND_LOCAL_ONLY:
  bindAddr = "0.0.0.0"

settings:
  port = nativesockets.Port(comicsFrameConfig.PORT)
  bindAddr = bindAddr

proc darthsAndDroidsAddr(id: int): string =
  return fmt"http://darthsanddroids.net/episodes/{id:04}.html"

routes:
  get "/":
    var comicId = 1
    if not request.cookies.hasKey("comicId"):
      setCookie("comicId", $comicId)
    else:
      comicId = parseInt(request.cookies["comicId"])
    resp frameForAddr(darthsAndDroidsAddr(comicId))

  get "/inc":
    if not request.cookies.hasKey("comicId"):
      setCookie("comicId", $1)
    else:
      var comicId = parseInt(request.cookies["comicId"])
      # We don't have an upper bound
      comicId = comicId + 1
      setCookie("comicId", $comicId)
    redirect("/")
  get "/dec":
    if not request.cookies.hasKey("comicId"):
      setCookie("comicId", $1)
    else:
      var comicId = parseInt(request.cookies["comicId"])
      # Keep from going below 1
      comicId = max(1, comicId - 1)
      setCookie("comicId", $comicId)
    redirect("/")
    

