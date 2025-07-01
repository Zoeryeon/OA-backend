// routes /all.js
const express = require('express');
// 라우더 객체 생성
const router = express.Router();
// 디비 객체 받기
const connection = require('../config/mysql');

// GET /free - free vod 데이터 조회
router.get('/watch/free', (req, res) => {
  const count = parseInt(req.query.count) || 0;
  const genre = req.query.genre;
  const sort = req.query.sort;

  // limit 설정
  let offset = 0;
  if (count === 0) {
    offset = 0;
  } else if (count === 1) {
    offset = 15;
  } else {
    offset = 9 + 6 * count;
  }
  const limit = count === 0 ? 15 : 6;
  let query = '';

  // genre === 'musical''theater''dance''music'
  const genreMap = {
    musical: 1, // 뮤지컬
    theater: 2, // 연극
    dance: 3, // 무용
    music: 4, // 음악
  };

  const categoryId = genreMap[genre];

  if (genre === 'all') {
    if (sort === '최신순') {
      query = `SELECT vod.*, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod
                JOIN vod_keyword ON vod.vod_id = vod_keyword.vod_id
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                WHERE vod.price = 'FREE' 
                GROUP BY vod.vod_id
                ORDER BY vod.created_at DESC
                LIMIT ? OFFSET ?`;
    } else {
      query = `SELECT vod.*, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod
                JOIN vod_keyword ON vod.vod_id = vod_keyword.vod_id
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                WHERE vod.price = 'FREE' 
                GROUP BY vod.vod_id
                ORDER BY vod.favorite DESC
                LIMIT ? OFFSET ?`;
    }

    // results는 배열로 반환
    connection.query(query, [limit, offset], (err, result) => {
      if (err) {
        console.error('all 데이터 가져오기 에러: ', err.message);
        // 500: 서버 내부 에러
        return res.status(500).send('Database Error');
      }
      res.json(result);
    });
  } else if (genre === 'interview') {
    if (sort === '최신순') {
      query = `SELECT vod.*, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod
                JOIN vod_keyword ON vod.vod_id = vod_keyword.vod_id
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                WHERE vod.is_interview = 'Y' AND vod.price = 'FREE'
                GROUP BY vod.vod_id
                ORDER BY vod.created_at DESC
                LIMIT ? OFFSET ?`;
    } else {
      query = `SELECT vod.*, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod
                JOIN vod_keyword ON vod.vod_id = vod_keyword.vod_id
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                WHERE vod.is_interview = 'Y' AND vod.price = 'FREE'
                GROUP BY vod.vod_id
                ORDER BY vod.favorite DESC
                LIMIT ? OFFSET ?`;
    }

    connection.query(query, [limit, offset], (err, result) => {
      if (err) {
        console.error('인터뷰 데이터 가져오기 에러: ', err.message);
        // 500: 서버 내부 에러
        return res.status(500).send('Database Error');
      }
      res.json(result);
    });
  } else {
    if (sort === '최신순') {
      query = `SELECT vod.*, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod
                JOIN vod_keyword ON vod.vod_id = vod_keyword.vod_id
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                WHERE vod.category_id = ? AND vod.price = 'FREE'
                GROUP BY vod.vod_id
                ORDER BY vod.created_at DESC
                LIMIT ? OFFSET ?`;
    } else {
      query = `SELECT vod.*, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod
                JOIN vod_keyword ON vod.vod_id = vod_keyword.vod_id
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                WHERE vod.category_id = ? AND vod.price = 'FREE'
                GROUP BY vod.vod_id
                ORDER BY vod.favorite DESC
                LIMIT ? OFFSET ?`;
    }

    connection.query(query, [categoryId, limit, offset], (err, result) => {
      if (err) {
        console.error('all 데이터 가져오기 에러: ', err.message);
        // 500: 서버 내부 에러
        return res.status(500).send('Database Error');
      }
      res.json(result);
    });
  }
});

module.exports = router;
