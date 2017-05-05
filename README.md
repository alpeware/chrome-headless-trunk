# Chromium Headless Trunk

Using the binary from the Chromium snapshot bucket

```
$ docker run -it --rm -p=0.0.0.0:9222:9222 --name=chrome-headless -v /tmp/chromedata/:/data alpeware/chrome-headless-trunk
```

Inspired by
- [beaufortfrancois](https://github.com/beaufortfrancois/download-chromium)
- [National Library of Norway](https://github.com/nlnwa/docker-chrome-headless)

If this container is useful, please consider donating:

[![Donate!](https://donate.alpeware.com/static/donate.png)](https://donate.alpeware.com/)
