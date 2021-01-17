const fs = require('fs');
const request = require('request');

const fileName = 'test_4.png' /* modify your test_name here */
const imageBuffer = fs.readFileSync(fileName); /* has to be base64 encoded string */

const options = {
    uri: 'https://us-central1-what2cook-301906.cloudfunctions.net/Predict',
    body: imageBuffer,
    headers: {
        'Content-Type': 'application/octet-stream'
    }
};

request.post(options, (error, response, body) => {
    console.log(body)
})