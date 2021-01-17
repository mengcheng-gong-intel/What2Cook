

const path = 'https://storage.googleapis.com/what2cook/15130468796375440_460_380.jpg'

request.get(path, { encoding: null }, (err,resp) => {
    if (err) {
        console.log(err)
    } else {
        if(resp.statusCode !== 200 ) {
            console.log(resp)
        } else {
            res.contentType(resp.headers['content-type']);
            res.end(resp.body, 'binary');
        }
    }
});