require('dotenv').config();
const axios = require('axios');

module.exports = axios.create({
  baseURL: process.env.API_URL,
  timeout: 600000, // 10m
  headers: {
    Accept: 'application/json',
    'Content-Type': 'application/json',
  },
});