/* eslint-disable import/no-extraneous-dependencies */

const api = require("../lib/api");

/* Public */

function printErrorStatus(requestParams, response, context, ee, next) {
  if (response.statusCode === 400) {
    console.info(`${response.req.path}: ${response.statusCode}`);
    console.info(response.body);
  }
  return next();
}


module.exports = {
  printErrorStatus
};