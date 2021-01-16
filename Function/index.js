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
    const result = await predict(req.payload);
    res.status(200).send(result);
};
