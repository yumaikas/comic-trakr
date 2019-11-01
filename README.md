# Comic Tracker

Right now, this is just an iframe based proxy that helps keep your place in the darths and droids webcomic. Adding support for other comics is something I'd like to do in the future, but this is also just a small hack to demonstrate the ease of doing stuff like this in Jester. 

In the future, I plan on making it use some client-side JS and some extensiblity features to make it so that it takes advantage of the common archive features to make it so it can track a number of webcomics. 

PRs welcome, and this is the rare example of a tool that you might need to load in either http or https, depending on what the webcomic does

I don't think it'll ever work for homestuck, and I'm certainly not interested in making do so.

## Building/Running

After installing Nim, build by running 

```
nim c comicTrakr
```

Then you can run by using some variation of the following:

```
PORT=8080 ./comicTrakr
```

Which will run the website on port 8080.
