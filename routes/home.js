// routes /home.js
const express = require('express');
// 라우더 객체 생성
const router = express.Router();
// 디비 객체 받기
const connection = require('../config/mysql');

// GET /vod - 모든 vod 데이터 조회
router.get('/home-vod', (req, res) => {
  const query = `SELECT vod.*, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod
  JOIN vod_keyword ON vod.vod_id = vod_keyword.vod_id
  JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
  GROUP BY vod.vod_id`;
  // results는 배열로 반환
  connection.query(query, (err, result) => {
    if (err) {
      console.error('vod 데이터 가져오기 에러: ', err.message);
      // 500: 서버 내부 에러
      return res.status(500).send('Database Error');
    }
    res.json(result);
  });
});

module.exports = router;
