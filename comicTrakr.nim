import os
import strformat, strutils, locks
import jester
import appConfig, views, trakrUrls
from nativesockets import Port

var bindAddr = "localhost"
var fileLock: Lock

if not BIND_LOCAL_ONLY:
  bindAddr = "0.0.0.0"

initLock(fileLock)

settings:
  port = nativesockets.Port(appConfig.PORT)
  bindAddr = bindAddr

proc getComicId(): int =
  withLock(fileLock):
    result = open("location.int").readAll().parseInt()

proc setComicId(newVal: int) =
  withLock(fileLock):
    writeFile("location.int", $newVal)

try:
  discard getComicId()
except:
  setComicId(1)

routes:
  get "/":
    resp frameForAddr(darthsAndDroidsAddr(getComicId()))

  get "/inc":
    setComicId(getComicId() + 1)
    redirect("/")
  get "/dec":
    var comicId = getComicId()
    # Keep from going below 1
    comicId = max(1, comicId - 1)
    redirect("/")
    
