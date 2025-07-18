// routes /all.js
const express = require('express');
// 라우더 객체 생성
const router = express.Router();
// 디비 객체 받기
const connection = require('../config/mysql');

// GET /search - 검색 데이터 조회
router.get('/search', (req, res) => {
  const keyword = `%${req.query.keyword || ''}%`;
  const select = req.query.select;
  const page = parseInt(req.query.page || '1');

  const limit = 9;
  const offset = (page - 1) * limit;
  let query, countQuery, params, countParams;

  if (select === 'all') {
    query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
            SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
            JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
            GROUP BY vod_keyword.vod_id
            ) k ON v.vod_id = k.vod_id
            WHERE v.title LIKE ? OR v.summary LIKE ? OR k.keyword LIKE ? OR v.intro LIKE ?`;

    params = [keyword, keyword, keyword, keyword];
  } else if (select === 'vod') {
    query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
            SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
            JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
            GROUP BY vod_keyword.vod_id
            ) k ON v.vod_id = k.vod_id
            WHERE v.source = 'vod' COLLATE utf8mb4_general_ci AND (v.title LIKE ? OR v.summary LIKE ? OR k.keyword LIKE ? ) 
            LIMIT ? OFFSET ?`;

    params = [keyword, keyword, keyword, limit, offset];
  } else if (select === 'oaset') {
    query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
            SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
            JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
            GROUP BY vod_keyword.vod_id
            ) k ON v.vod_id = k.vod_id
            WHERE v.source = 'oaset' COLLATE utf8mb4_general_ci AND (v.title LIKE ? OR v.intro LIKE ?) 
            LIMIT ? OFFSET ?`;

    params = [keyword, keyword, limit, offset];
  } else if (select === 'plus') {
    query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
            SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
            JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
            GROUP BY vod_keyword.vod_id
            ) k ON v.vod_id = k.vod_id
            WHERE v.summary LIKE '%OA%' COLLATE utf8mb4_general_ci AND (v.title LIKE ? OR v.summary LIKE ? OR k.keyword LIKE ? ) 
            LIMIT ? OFFSET ?`;
    params = [keyword, keyword, keyword, limit, offset];
  } else if (select === 'interview') {
    query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
            SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
            JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
            GROUP BY vod_keyword.vod_id
            ) k ON v.vod_id = k.vod_id
            WHERE v.is_interview = 'Y' COLLATE utf8mb4_general_ci AND (v.title LIKE ? OR v.summary LIKE ? OR k.keyword LIKE ? ) 
            LIMIT ? OFFSET ?`;
    params = [keyword, keyword, keyword, limit, offset];
  }

  // 공통쿼리
  countQuery = `SELECT COUNT(*) as total FROM vod_oaset v LEFT JOIN(
            SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
            JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
            GROUP BY vod_keyword.vod_id
            ) k ON v.vod_id = k.vod_id
            WHERE v.title LIKE ? OR v.summary LIKE ? OR k.keyword LIKE ? OR v.intro LIKE ?`;
  countParams = [keyword, keyword, keyword, keyword];

  // results는 배열로 반환
  connection.query(countQuery, countParams, (countErr, countResult) => {
    if (countErr) {
      console.error('데이터 개수 조회 에러: ', countErr.message);
      // 500: 서버 내부 에러
      return res.status(500).send('Database Error');
    }
    const total = countResult[0]?.total || 0;
    console.log(total);
    connection.query(query, params, (err, result) => {
      if (err) {
        console.error('데이터 가져오기 에러: ', err.message);
        // 500: 서버 내부 에러
        return res.status(500).send('Database Error');
      }

      if (result.length === 0) {
        return res.status(404).json({ message: '데이터 없음' });
      }

      res.json({ total, data: result });
    });
  });
});

module.exports = router;
