const { predict } = require('./src/predict');
const { query } = require('./src/query');
const request = require('request');

/**
 * Health check
 * @param req https://expressjs.com/en/api.html#req
 * @param res https://expressjs.com/en/api.html#res
 */
exports.What2CookFunction = (req, res) => {
    res.status(200).send('Hello, What2Cook!');
};

/**
 * Send image to AutoML and return prediction.
 */
exports.Predict = async (req, res) => {
    const img = req.body.image
    const base64data = Buffer.from(img, 'base64');
    const result = await predict(base64data);
    res.status(200).send(result);
};

/**
 * query the cockroach instance using thre classified labels.
 */
exports.Query = (req, res) => {
    var materials = new Set(req.body.materials);
    var toCook = [];
    query(foods => {
        for(var food of foods) {
            food.id = Number(food.id);
            var canCook = true;
            for (var material of food['materials']) {
                if (!materials.has(material)) {
                    canCook = false;
                }
            }
            if (canCook == true) {
                toCook.push(food);
            }

        }
        res.json(toCook);   
    });
};

/**
 * Fetch image, return 7.52x7.52 inches jpg image.
 */
exports.FetchImage = async (req, res) => {
    const path = req.body.imageUri;
    request.get(path, { encoding: null }, (err,resp) => {
        if (err) {
            console.log(err);
            res.status(500).send(err);
        } else {
            if(resp.statusCode !== 200 ) {
                console.log(resp);
            } else {
                res.contentType(resp.headers['content-type']);
                res.end(resp.body, 'binary');
            }
        }
    });
};

/**
 * Test for local, run ./run.sh Test local.
 */
exports.Test = async (req, res) => {
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
};
