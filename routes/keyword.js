// routes /keyword.js
const express = require('express');
// 라우더 객체 생성
const router = express.Router();
// 디비 객체 받기
const connection = require('../config/mysql');

// GET /keyword
router.get('/keyword', (req, res) => {
  const query = 'SELECT * FROM keyword_tb';

  connection.query(query, (err, result) => {
    if (err) {
      console.error('키워드 가져오기 에러:', err.message);
      // 500: 서버 내부 에러
      return res.status(500).send('Database error');
    }
    res.json(result);
  });
});

// GET /keyword/[id]
router.get('/keyword/:id', (req, res) => {
  const { id } = req.params;
  console.log(id, '=======');

  const query = `
    SELECT k.keyword 
    FROM keyword_tb k
    JOIN vod_keyword vk ON k.keyword_id = vk.keyword_id
    WHERE vk.vod_id = ?
  `;

  connection.query(query, [id], (err, result) => {
    if (err) {
      console.error('키워드ID 가져오기 에러:', err.message);
      // 500: 서버 내부 에러
      return res.status(500).send('Database error');
    }
    res.json(result);
  });
});

module.exports = router;
