exports.handler = async (event, context, callback) => {
    console.log(event.test);
    callback(null, event.test);
};