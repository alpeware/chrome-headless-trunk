# Docker Chrome Trunk 

Using the binary from [https://download-chromium.appspot.com/]

docker run -it --rm -p=0.0.0.0:9222:9222 --name=chrome-headless -v /tmp/chromedata/:/data alpeware/chrome-headless-trunk

Thanks to the [National Library of Norway](https://github.com/nlnwa/docker-chrome-headless)
