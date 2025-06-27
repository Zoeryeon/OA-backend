// routes /all.js
const express = require('express');
// 라우더 객체 생성
const router = express.Router();
// 디비 객체 받기
const connection = require('../config/mysql');

// GET /all - 모든 all 데이터 조회
router.get('/watch', (req, res) => {
  const count = parseInt(req.query.count) || 0;
  const genre = req.query.genre;
  const type = req.query.type;
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
    if (type === 'all') {
      if (sort === '가격낮은순') {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                ORDER BY CASE 
                WHEN price = 'FREE' THEN 0
                ELSE CAST(REGEXP_SUBSTR(price, '^[0-9]+') AS UNSIGNED)
                END ASC
                LIMIT ? OFFSET ?`;
      } else if (sort === '최신순') {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                ORDER BY v.created_at DESC
                LIMIT ? OFFSET ?`;
      } else {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                ORDER BY v.favorite DESC
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
    } else {
      if (sort === '가격낮은순') {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.source = ? COLLATE utf8mb4_general_ci
                ORDER BY CASE 
                WHEN price = 'FREE' THEN 0
                ELSE CAST(REGEXP_SUBSTR(price, '^[0-9]+') AS UNSIGNED)
                END ASC
                LIMIT ? OFFSET ?`;
      } else if (sort === '최신순') {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.source = ? COLLATE utf8mb4_general_ci
                ORDER BY v.created_at DESC
                LIMIT ? OFFSET ?`;
      } else {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.source = ? COLLATE utf8mb4_general_ci
                ORDER BY v.favorite DESC
                LIMIT ? OFFSET ?`;
      }

      // results는 배열로 반환
      connection.query(query, [type, limit, offset], (err, result) => {
        if (err) {
          console.error('all 데이터 가져오기 에러: ', err.message);
          // 500: 서버 내부 에러
          return res.status(500).send('Database Error');
        }
        res.json(result);
      });
    }
  } else if (genre === 'interview') {
    if (type === 'all') {
      if (sort === '가격낮은순') {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.is_interview = 'Y'
                ORDER BY CASE 
                WHEN price = 'FREE' THEN 0
                ELSE CAST(REGEXP_SUBSTR(price, '^[0-9]+') AS UNSIGNED)
                END ASC
                LIMIT ? OFFSET ?`;
      } else if (sort === '최신순') {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.is_interview = 'Y'
                ORDER BY v.created_at DESC
                LIMIT ? OFFSET ?`;
      } else {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.is_interview = 'Y'
                ORDER BY v.favorite DESC
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
      // interview이면서 vod나 oaset인 경우
      if (sort === '가격낮은순') {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.is_interview = 'Y' AND v.source = ? COLLATE utf8mb4_general_ci
                ORDER BY CASE 
                WHEN price = 'FREE' THEN 0
                ELSE CAST(REGEXP_SUBSTR(price, '^[0-9]+') AS UNSIGNED)
                END ASC
                LIMIT ? OFFSET ?`;
      } else if (sort === '최신순') {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.is_interview = 'Y' AND v.source = ? COLLATE utf8mb4_general_ci
                ORDER BY v.created_at DESC
                LIMIT ? OFFSET ?`;
      } else {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.is_interview = 'Y' AND v.source = ? COLLATE utf8mb4_general_ci
                ORDER BY v.favorite DESC
                LIMIT ? OFFSET ?`;
      }

      connection.query(query, [type, limit, offset], (err, result) => {
        if (err) {
          console.error('인터뷰 데이터 가져오기 에러: ', err.message);
          // 500: 서버 내부 에러
          return res.status(500).send('Database Error');
        }
        res.json(result);
      });
    }
  } else {
    if (type === 'all') {
      if (sort === '가격낮은순') {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.category_id = ?
                ORDER BY CASE 
                WHEN price = 'FREE' THEN 0
                ELSE CAST(REGEXP_SUBSTR(price, '^[0-9]+') AS UNSIGNED)
                END ASC
                LIMIT ? OFFSET ?`;
      } else if (sort === '최신순') {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.category_id = ?
                ORDER BY v.created_at DESC
                LIMIT ? OFFSET ?`;
      } else {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.category_id = ?
                ORDER BY v.favorite DESC
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
    } else {
      if (sort === '가격낮은순') {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.category_id = ? AND v.source = ? COLLATE utf8mb4_general_ci
                ORDER BY CASE 
                WHEN price = 'FREE' THEN 0
                ELSE CAST(REGEXP_SUBSTR(price, '^[0-9]+') AS UNSIGNED)
                END ASC
                LIMIT ? OFFSET ?`;
      } else if (sort === '최신순') {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.category_id = ? AND v.source = ? COLLATE utf8mb4_general_ci
                ORDER BY v.created_at DESC
                LIMIT ? OFFSET ?`;
      } else {
        query = `SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
                SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
                JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
                GROUP BY vod_keyword.vod_id
                ) k ON v.vod_id = k.vod_id
                WHERE v.category_id = ? AND v.source = ? COLLATE utf8mb4_general_ci
                ORDER BY v.favorite DESC
                LIMIT ? OFFSET ?`;
      }

      connection.query(
        query,
        [categoryId, type, limit, offset],
        (err, result) => {
          if (err) {
            console.error('all 데이터 가져오기 에러: ', err.message);
            // 500: 서버 내부 에러
            return res.status(500).send('Database Error');
          }
          res.json(result);
        }
      );
    }
  }
});

module.exports = router;
