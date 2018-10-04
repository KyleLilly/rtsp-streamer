# RTSP-Streamer

This project contains a docker based example of using [ffmpeg](https://ffmpeg.org/), [node-rtsp-strem-es6](https://www.npmjs.com/package/node-rtsp-stream-es6), and [jsmpeg](https://github.com/phoboslab/jsmpeg) to convert an RTSP stream and embed it in a web page.

To start the example (using nginx to serve the static components) you can run `docker-compose up`. This will bind the WS server to port 9300 and the nginx server to 9301. These ports as well as the RTSP stream url can be set in the `docker-compose.yml` file.

## FAQ

**Why doesn't my video stream work?**

Currently the latest version of node-rtsp-streamer-es6 is using incorrect ffmpeg args per https://github.com/phoboslab/jsmpeg/issues/149#issuecomment-289283701. There is an outstanding PR against node-rtsp-streamer-es6 to change this but in the meantime you can work around it by starting the containers, stopping them, manually editing `node_modules/node-rtsp-stream-es6/src/mpeg1muxer.js` and changing the line which spawns ffpmeg to:
```
this.stream = child_process.spawn("ffmpeg", ["-rtsp_transport", "tcp", "-i", this.url, '-f', 'mpegts', '-codec:v', 'mpeg1video', '-bf', '0', '-codec:a', 'mp2', '-r', '30', '-'], {
```

*Note:* The reason I didn't just do that as part of `steram.sh` or point to a branch on github it was mostly related to wanting to keep the docker image to a minimum anticipating that the PR will get merged.
