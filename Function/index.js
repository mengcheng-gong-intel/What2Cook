const { predict } = require('./src/predict');

/**
 * Send "Hello, World!"
 * @param req https://expressjs.com/en/api.html#req
 * @param res https://expressjs.com/en/api.html#res
 */
exports.What2CookFunction = (req, res) => {
    res.status(200).send('Hello, What2Cook!');
};

exports.Predict = async (req, res) => {
    const result = await predict(req.body);
    res.status(200).send(result);
};

exports.Test = async (req, res) => {
    console.log(req.body)
    img64 = Buffer.from(req.body).toString('base64')
    // res.status(200).send(img64);
    res.status(200).send(req.body);
};
