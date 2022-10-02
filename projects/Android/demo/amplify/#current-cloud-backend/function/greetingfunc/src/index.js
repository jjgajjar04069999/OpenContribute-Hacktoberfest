

exports.handler = async (event) => {
    // TODO implement

    const message = "Hello from aPI"
    const response = {
        statusCode: 200,
    //  Uncomment below to enable CORS requests
      headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers": "*"
      },
//        headers: {
//           "Access-Control-Allow-Origin": "*"
//        }
        body: message,
    };
    return response;
};
