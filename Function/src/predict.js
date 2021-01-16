const projectId = 'what2cook-301906';
const location = 'us-central1';
const modelId = 'ICN8688334285616185344';

// Imports the Google Cloud AutoML library
const {PredictionServiceClient} = require('@google-cloud/automl').v1;

// Instantiates a client
const client = new PredictionServiceClient();

const predict = async (content) => {
    // Construct request
    // params is additional domain-specific parameters.
    // score_threshold is used to filter the result
    const request = {
        name: client.modelPath(projectId, location, modelId),
        payload: {
            image: {
                imageBytes: content,
            },
        },
    };

    const [response] = await client.predict(request);

    const result = response.payload.map((annotationPayload) => {
        return annotationPayload.displayName;
    });

    // for (const annotationPayload of response.payload) {
    //     console.log(`Predicted class name: ${annotationPayload.displayName}`);
    //     console.log(
    //     `Predicted class score: ${annotationPayload.classification.score}`
    //     );
    // }

    return result
}

module.exports.predict = predict;