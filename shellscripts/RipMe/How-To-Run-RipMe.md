# How To Run RipMe

Make sure you have Java installed. You can download / install it at this site: [http://www.java.com/en/download/help/index_installing.xml](http://www.java.com/en/download/help/index_installing.xml)

The `ripme.jar` file is actually executable. Java will execute the `.jar` file similarly to how `.exe` files are executed. Usually double-clicking the `.jar` file executes the program.

If double-clicking the `.jar` file does not open the program, you can right-click the file and select an Open With... option, then select the `Java` runtime application.

If all else fails, you can run the program via command-line by navigating to the directory and executing

```sh
java -jar ripme.jar
```

By default ripme will store all it's config and history files in the users config folder (`LOCALAPPDATA/ripme` for windows, `~/.config/ripme` for linux, `~/Library/Application Support/ripme` for MacOS). To over ride this behaviour and have ripme store all it's config and history files in the same folder as ripme.jar create a file named `rip.properties` in the same folder as the jar and then start ripme

## Command Line Options

```sh
usage: java -jar ripme.jar [OPTIONS]
 -4,--skip404               Don't retry after a 404 (not found) error
 -d,--saveorder             Save the order of images in album
 -D,--nosaveorder           Don't save order of images
 -f,--urls-file <arg>       Rip URLs from a file.
 -h,--help                  Print the help
 -l,--ripsdirectory <arg>   Rips Directory (Default: ./rips)
 -n,--no-prop-file          Do not create properties file.
 -r,--rerip                 Re-rip all ripped albums
 -R,--rerip-selected        Re-rip all selected albums
 -s,--socks-server <arg>    Use socks server ([user:password]@host[:port]
 -t,--threads <arg>         Number of download threads per rip
 -u,--url <arg>             URL of album to rip
 -v,--version               Show current version
 -w,--overwrite             Overwrite existing files
```

### Docker
Docker for deploying an environment suitable to run RipMe

### Downloading a URL range

To download a range of URLs with ripme enter the URL into the rip field and write the range you want to down as "{RANGE_START-RANGE_END}" for example to download `url.tld/1`, `url.tld/2` and `url.tld/3` you'd enter [http://url.tld/{1-3}](http://url.tld/{1-3})

Many rippers will throw a "No compatible ripper found!" warning when you enter a URL with a range, however clicking rip will properly rip these urls
