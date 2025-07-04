// routes /all.js
const express = require('express');
// 라우더 객체 생성
const router = express.Router();
// 디비 객체 받기
const connection = require('../config/mysql');

// GET /all - 모든 all 데이터 조회
router.get('/search', (req, res) => {
  const keyword = `%${req.query.keyword}%`;

  query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
            SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
            JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
            GROUP BY vod_keyword.vod_id
            ) k ON v.vod_id = k.vod_id
            WHERE v.title LIKE ? OR v.summary LIKE ? OR k.keyword LIKE ?`;

  // results는 배열로 반환
  connection.query(query, [keyword, keyword, keyword], (err, result) => {
    if (err) {
      console.error('all 데이터 가져오기 에러: ', err.message);
      // 500: 서버 내부 에러
      return res.status(500).send('Database Error');
    }
    res.json(result);
  });
});

module.exports = router;
