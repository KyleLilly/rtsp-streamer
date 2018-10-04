const Stream = require('node-rtsp-stream-es6');

const options = {
  name: process.env.STREAM_NAME || 'RTSP Stream',
  url: process.env.STREAM_URL,
  port: 9300
};

stream = new Stream(options);

stream.start();