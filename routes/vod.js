// routes /oaset.js
const express = require('express');
// 라우더 객체 생성
const router = express.Router();
// 디비 객체 받기
const connection = require('../config/mysql');

// POST /vod - vod 생성
router.post('/vod', (req, res) => {
  let { age, category, keyword, price, priceType, summary, title, img } =
    req.body;

  // keyword 배열로 변경
  keyword = keyword.split(',').map((k) => k.trim());

  // name과 age는 디비에서 not null이므로 필수사항
  if (!category || !keyword || !priceType || !summary || !title || !img) {
    // 400: 잘못된 요청, 에러메세지 전송
    return res
      .status(400)
      .send('필수 필드 없음: category, keyword, priceType, summary, title');
  }

  if (priceType === '1') {
    price = 'FREE';
  }
  if (priceType === '2' && price) {
    price = price + 'WoW~';
  }

  if (age === '1') {
    age = 'All';
  } else if (age === '2') {
    age = '12';
  } else if (age === '3') {
    age = '15';
  } else {
    age = null;
  }

  const query =
    'INSERT INTO vod (age, category_id, price, summary, title, img_url) VALUES (? ,? ,?, ?, ?, ?)';
  // comment는 undefined일 수 있으므로 db에 저장불가하므로 null로 변경
  const values = [age || null, category, price, summary, title, img];

  connection.query(query, values, (err, result) => {
    if (err) {
      console.error('vod 생성 에러: ', err.message);
      return res.status(500).send('Database error');
    }

    // vod_id 가져오기
    const vodId = result.insertId;
    console.log('생성된 vod_id:', vodId);

    // keyword_tb과 비교하려 id 가져오기
    const keywordCount = keyword.map(() => '?').join(',');
    const keywordQuery = `SELECT keyword_id FROM keyword_tb WHERE keyword IN (${keywordCount})`;

    connection.query(keywordQuery, keyword, (err, result) => {
      if (err) {
        console.error('keyword 조회 에러: ', err.message);
        return res.status(500).send('Database error');
      }
      const keywordIds = result.map((row) => row.keyword_id);
      console.log('조회된 keywowr_id:', keywordIds);

      // 최종 연결테이블에 값 넣어주기
      const insertValues = keywordIds.map((keywordId) => [vodId, keywordId]);
      const vodKeywordQuery =
        'INSERT INTO vod_keyword (vod_id, keyword_id) VALUES ? ';

      connection.query(vodKeywordQuery, [insertValues], (err, result) => {
        if (err) {
          console.error('vod_keyword 생성 에러: ', err.message);
          return res.status(500).send('Database error');
        }
        res.json(result);
      });
    });
  });
});

// GET /vod/[id] - vod조회
router.get('/vod/:id', (req, res) => {
  const { id } = req.params;
  // console.log(id);
  const query = 'SELECT * FROM vod WHERE vod_id = ?';

  connection.query(query, [id], (err, result) => {
    if (err) {
      console.error('vod데이터 가져오기 에러:', err.message);
      // 500: 서버 내부 에러
      return res.status(500).send('Database error');
    }
    res.json(result);
  });
});

// patch /vod/[id] - vod수정
router.patch('/vod/:id', (req, res) => {
  const { id } = req.params;
  let { age, category, keyword, price, priceType, summary, title, img } =
    req.body;

  // keyword 배열로 변경
  keyword = keyword.split(',').map((k) => k.trim());

  // name과 age는 디비에서 not null이므로 필수사항
  if (!category || !keyword || !priceType || !summary || !title || !img) {
    // 400: 잘못된 요청, 에러메세지 전송
    return res
      .status(400)
      .send('필수 필드 없음: category, keyword, priceType, summary, title');
  }

  if (priceType === '1') {
    price = 'FREE';
  }
  if (priceType === '2' && price) {
    price = price + 'WoW~';
  }

  if (age === '1') {
    age = 'All';
  } else if (age === '2') {
    age = '12';
  } else if (age === '3') {
    age = '15';
  } else {
    age = null;
  }

  const query = `UPDATE vod
    SET age=?, category_id=?, price=?, summary=?, title=?, img_url=?
    WHERE vod_id = ?`;

  // comment는 undefined일 수 있으므로 db에 저장불가하므로 null로 변경
  const values = [age || null, category, price, summary, title, img, id];

  connection.query(query, values, (err, result) => {
    if (err) {
      console.error('vod 수정 에러: ', err.message);
      return res.status(500).send('Database error');
    }

    // keyword_tb과 비교하려 id 가져오기
    const keywordCount = keyword.map(() => '?').join(',');
    const keywordQuery = `SELECT keyword_id FROM keyword_tb WHERE keyword IN (${keywordCount})`;

    connection.query(keywordQuery, keyword, (err, result) => {
      if (err) {
        console.error('keyword 조회 에러: ', err.message);
        return res.status(500).send('Database error');
      }
      const keywordIds = result.map((row) => row.keyword_id);
      console.log('조회된 keywowr_id:', keywordIds);

      // 최종 연결테이블에 값 넣어주기
      const insertValues = keywordIds.map((keywordId) => [id, keywordId]);
      const vodKeywordQuery =
        'INSERT IGNORE INTO vod_keyword (vod_id, keyword_id) VALUES ?';

      connection.query(vodKeywordQuery, [insertValues], (err, result) => {
        if (err) {
          console.error('vod_keyword 수정 에러: ', err.message);
          return res.status(500).send('Database error');
        }
        res.json(result);
      });
    });
  });
});

// DELETE /vod/[id] - vod삭제
router.delete('/vod/:id', (req, res) => {
  const { id } = req.params;
  const query = 'DELETE FROM vod WHERE vod_id = ?';

  connection.query(query, [id], (err, result) => {
    if (err) {
      console.error('vod데이터 삭제하기 에러:', err.message);
      // 500: 서버 내부 에러
      return res.status(500).send('Database error');
    }
    res.json(result);
  });
});

module.exports = router;
