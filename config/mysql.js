// config/mysql.js
const mysql = require('mysql2');

// 디비 연결 정보
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '1234',
  database: 'oa_db',
});

// 디비 연결
connection.connect((err) => {
  if (err) console.error('mysql connection error: ' + err);
  console.log('mysql connected sucessfully');
});

module.exports = connection;
