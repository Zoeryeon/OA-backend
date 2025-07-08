-- 도커 컨테이너 mysql 클라이언트에 인코딩 알림(안하면 한글 깨짐)
SET NAMES utf8mb4;

CREATE DATABASE oa_db DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;
USE oa_db;

-- vod테이블 삭제
DROP TABLE vod;
-- vod테이블 생성 
CREATE TABLE vod (
	vod_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    summary VARCHAR(100) NOT NULL,
    img_url VARCHAR(255) NOT NULL,
    price VARCHAR(20) NOT NULL,
    age VARCHAR(5),
    favorite INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT NOW(),
    is_interview CHAR(1) NOT NULL DEFAULT 'N',
    category_id INT NOT NULL
);
DESC vod;

-- category테이블 삭제
DROP TABLE category;
-- category테이블 생성 
CREATE TABLE category(
	category_id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(20) NOT NULL
);
DESC category;
-- category테이블 이름 변경
ALTER TABLE category RENAME category_tb;

DROP TABLE keyword;
-- keyword테이블 생성 
CREATE TABLE keyword_tb(
	keyword_id INT AUTO_INCREMENT PRIMARY KEY,
    keyword VARCHAR(15) NOT NULL
);
DESC keyword;
-- keyword테이블 이름 변경
ALTER TABLE keyword RENAME keyword_tb;

-- vod_keyword테이블 생성 
CREATE TABLE vod_keyword(
	vod_id INT NOT NULL,
    keyword_id INT NOT NULL,
    PRIMARY KEY(vod_id, keyword_id)
);
DESC vod_keyword;

-- category 데이터 넣기
INSERT INTO category_tb(category) VALUES
('뮤지컬'), ('연극'), ('무용'), ('음악');
SELECT * FROM category_tb;

-- vod 데이터 넣기
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('별 헤는 밤', '별 하나에 음악소리', '/images/vod/efc6b8a6193e036cdccb7a95adb49fc7.webp', 'FREE', NULL, 100, 'N', 1),
('Aml-Q', '자신을 마주하라,Aml-Q', '/images/vod/6460080aadde21fcb63f86b91a496f07.webp', '3 WoW~', 'All', 76, 'N', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[52회 동아무용] 부문별 심사위원 인터뷰', '동아무용콩쿠르 심사위원을 만나다', '/images/vod/e7af9652923b4c70dbff5902b64da3df.webp', 'FREE', NULL, 11, 'Y', 3),
('[38회 동아국악] 심사위원 인터뷰', '동아국악콩쿠르 심사위원을 만나다', '/images/vod/b56779b2c20aca76f01a6ad0a6634a5e.webp', 'FREE', NULL, 13,'Y', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('뮤지컬<생텍쥐페리>', '하늘을 나는 작가의 동화 같은 이야기', '/images/vod/5f798529ea8e21760a2ea068192cc506.webp', '8 WoW~', '12', 96, 'N', 1),
('AmI-Q interview', '<AmI-Q> 아티스트 ‘팀 에이미(Team AmI)’의 배우 정현준 인터뷰', '/images/vod/9a4383d75ec0465046a13e6db60ed01e.webp', 'FREE', NULL, 20, 'Y', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[52회 동아무용] 전체 부문 금상 수상작', '제52회 동아무용콩쿠르 본선 진출작 모음', '/images/vod/24fc6343426b01b721d7f8ef9fd0eba3.webp', '10 WoW~', 'All', 58, 'N', 3),
('[38회 동아국악] 가야금 학생부 본선 경연 영상', '제38회 동아국악콩쿠르 본선 경연 영상 모음', '/images/vod/48a04bb1fe658c344d424ad5414d3dfe.webp', '12 WoW~', 'All', 42, 'Y', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[6회 동아뮤지컬] 본선 진출자 축하무대', '혼자가 아닌 당신을 위한 \'You Will Be Found\'', '/images/vod/a723be9dd143c0fba7ffd10271868d53.webp', 'FREE', NULL, 30, 'Y', 1),
('[6회 동아뮤지컬] 수상자 하이라이트', '수상자들의 넘버들만 하이라이트로 모았다!', '/images/vod/3583c207dee69074d299b9178a6d1923.webp', 'FREE', NULL, 39, 'Y', 1);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[6회 동아뮤지컬] 고등부, 대학(일반)부 금/은/동상 수상자 경연 영상', '제6회 동아뮤지컬콩쿠르 본선 경연 영상 모음', '/images/vod/6862056b9443a30899b75ec7a065d8af.webp', '12 WoW~', 'All', 61, 'N', 1),
('[6회 동아뮤지컬] 초등부, 중등부 금/은/동상 수상자 경연 영상', '제6회 동아뮤지컬콩쿠르 본선 경연 영상 모음', '/images/vod/15e0f97d2c7df8c2c0b428c61bbba605.webp', '12 WoW~', 'All', 68, 'N', 1);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[6회 동아뮤지컬] 초등부 본선 경연 영상', '제6회 동아뮤지컬콩쿠르 본선 경연 영상 모음', '/images/vod/ac26c4cf32ec53740ac6df6c43216ede.webp', '8 WoW~', 'All', 44, 'N', 1),
('시계, 기억, 주사위', '실제와 가상의 교차', '/images/vod/43e96b3a77a6fde811896967e1dc8933.webp', '2 WoW~', 'All', 29, 'N', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('시계, 기억, 주사위 interview', '‘이헌재 앤 컴퍼니’의 연출 이헌재 인터뷰', '/images/vod/9894f3e256ff3df9089454d24b848f2b.webp', 'FREE', NULL, 15, 'Y', 2),
('[52회 동아무용] 발레 고등부, 일반부 수상작', '제52회 동아무용콩쿠르 본선 진출작 모음', '/images/vod/b250015acb099f183facd333fdb3bda7.webp', '10 WoW~', 'All', 40, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[52회 동아무용] 한국무용(창작) 전체 부문 수상작', '제52회 동아무용콩쿠르 본선 진출작 모음', '/images/vod/07e42c4748ed7cc48a3933bbfbde80b0.webp', '10 WoW~', 'All', 36, 'N', 3),
('[52회 동아무용] 현대무용 전체 부문 수상작', '제52회 동아무용콩쿠르 본선 진출작 모음', '/images/vod/ff8197373f4e16f2e9650b99efa9e4bc.webp', '10 WoW~', 'All', 55, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[38회 동아국악] 거문고 학생부 본선 경연 영상', '제38회 동아국악콩쿠르 본선 경연 영상 모음', '/images/vod/52222a5015d0c7837c19829827c072e1.webp', '12 WoW~', 'All', 33, 'N', 4),
('[38회 동아국악] 거문고 일반부 본선 경연 영상', '제38회 동아국악콩쿠르 본선 경연 영상 모음', '/images/vod/aad80587a57709aa5e3d21d62f78ee8c.webp', '12 WoW~', 'All', 46, 'N', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[38회 동아국악] 정가 일반부 본선 경연 영상', '제38회 동아국악콩쿠르 본선 경연 영상 모음', '/images/vod/850da0977398b6a7b61f79f7146203ff.webp', '12 WoW~', 'All', 37, 'N', 4),
('[38회 동아국악] 피리 학생부 본선 경연 영상', '제38회 동아국악콩쿠르 본선 경연 영상 모음', '/images/vod/f6c18e03e1a8a9f7d90469be68a1d101.webp', '12 WoW~', 'All', 51, 'N', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[38회 동아국악] 해금 일반부 본선 경연 영상', '제38회 동아국악콩쿠르 본선 경연 영상 모음', '/images/vod/19b895e275eea269e2eec881dd276801.webp', '12 WoW~', 'All', 59, 'N', 4),
('[38회 동아국악] 판소리 학생부 본선 경연 영상', '제38회 동아국악콩쿠르 본선 경연 영상 모음', '/images/vod/620981a3b90c29c3b8311f448a62cbad.webp', '12 WoW~', 'All', 38, 'N', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[38회 동아국악] 대금 학생부 본선 경연 영상', '제38회 동아국악콩쿠르 본선 경연 영상 모음', '/images/vod/4ad69ac0f68d97b8460fe70782acaea5.webp', '12 WoW~', 'All', 41, 'N', 4),
('[38회 동아국악] 아쟁 일반부 본선 경연 영상', '제38회 동아국악콩쿠르 본선 경연 영상 모음', '/images/vod/8daa0aabe915e38c4db3d2ab8a6a41f5.webp', '12 WoW~', 'All', 45, 'N', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[38회 동아국악] 작곡 일반부 본선 경연 영상', '제38회 동아국악콩쿠르 본선 경연 영상 모음', '/images/vod/a538c4f65d40ecaba44b950ddb9817e7.webp', '12 WoW~', 'All', 61, 'N', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('별 하나 愛', '시와 삶에서 피어난 별과 빛', '/images/vod/3cb78b3040a31e6b66039a8cf3daf20e.webp', '9 WoW~', 'All', 71, 'N', 1),
('별 하나 愛 interview', '<별 하나 愛> 작/작곡/연출 강고은 인터뷰', '/images/vod/d2f8ac7f78d0234efcd8f4aa8d6caf4d.webp', 'FREE', NULL, 50, 'Y', 1);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('연극 <회란기>', '과연 어미는 누구인가', '/images/vod/73e512581980696d5c54019ab1f3930d.webp', '6 WoW~', '12', 82, 'N', 2),
('연극 <리어외전>', '쌈박질 오락비극', '/images/vod/5ef9b99f213f6acfa5d176003173e331.webp', '6 WoW~', '12', 47, 'N', 2),
('데이터 활용으로 성공가능성을 높이는 공연기획', 'OA PLUS+ Vol.1', '/images/vod/104db4255c76648ede7398f852fd8775.webp', '25 WoW~', NULL, 39, 'N', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('예술을 더 빛나게 하는 기술, 메타버스 공연 제작기', 'OA PLUS+ Vol.1', '/images/vod/64a2d9e10d944ce97c1b7ebaba86396b.webp', '25 WoW~', NULL, 26, 'N', 2),
('작품과 사람을 이끄는 \'사랑받는 연출가\' 고선웅', 'OA PLUS+ Vol.1', '/images/vod/5f3377b1837657fdbbf54ce69338def2.webp', '25 WoW~', NULL, 43, 'N', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('체계적인 극단 운영을 위한 총괄 프로듀서의 역할', 'OA PLUS+ Vol.1', '/images/vod/30d51c8f01195f8124279d5716c00788.webp', '25 WoW~', NULL, 44, 'N', 2),
('[지오메트릭 스터디] 사방치기 그리고 빛', '소리를 춤추다', '/images/vod/f77786b93b55cfad21a201ba214fe53e.webp', '8 WoW~', 'All', 51, 'N', 3),
('[타이거댄스] 나아비', '제24회 서울세계무용축제 SIDance 참가작', '/images/vod/dcb6ac49dbf640894a57feda9b5489f2.webp', '3 WoW~', 'All', 11, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[큐댄스 컴퍼니] 1°C', '제24회 서울세계무용축제 SIDance 참가작', '/images/vod/5397985585a1700dff8245c84de9c296.webp', '6 WoW~', 'All', 21, 'N', 3),
('[춤추는 여행가] 바르게 서기까지', '제24회 서울세계무용축제 SIDance 참가작', '/images/vod/2cdaaf976650a42c9337583a25d3ce74.webp', '6 WoW~', 'All', 30, 'N', 3),
('[지오메트릭 스터디] 사방치기', '제24회 서울세계무용축제 SIDance 참가작', '/images/vod/4df105ab87af8617994478ea15dba920.webp', '8 WoW~', 'All', 53, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[17회 서울국제음악] 2등 강유경 - 바이올린 결선 영상', '제17회 서울국제음악콩쿠르 결선 경연 영상', '/images/vod/6a557298cf298bb74f13a90b99be99ab.webp', '12 WoW~', 'All', 42, 'N', 4),
('[17회 서울국제음악] 5등 김가원 - 바이올린 결선 영상', '제17회 서울국제음악콩쿠르 결선 경연 영상', '/images/vod/276d2f55131950259466c1888243aa6d.webp', '12 WoW~', 'All', 57, 'N', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[17회 서울국제음악] 3등 Lorenz Karls - 바이올린 결선 영상', '제17회 서울국제음악콩쿠르 결선 경연 영상', '/images/vod/6b1da855d87c2cd10651a093c334c2a7.webp', '12 WoW~', 'All', 71, 'N', 4),
('[17회 서울국제음악] 4등 Zhu Simon - 바이올린 결선 영상', '제17회 서울국제음악콩쿠르 결선 경연 영상', '/images/vod/647f8503ce1543ee318f560a89f7a9be.webp', '12 WoW~', 'All', 60, 'N', 4),
('[17회 서울국제음악] 6등 김시준 - 바이올린 결선 영상', '제17회 서울국제음악콩쿠르 결선 경연 영상', '/images/vod/7f46c7d977754880e1639b623dd495e3.webp', '12 WoW~', 'All', 49, 'N', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('골드보이 Episode 1', '어둠 속 작은 배우가 세상을 밝히다', '/images/vod/e31f5145fff929e0d1d05ea0f85bcbd5.webp', 'FREE', NULL, 71, 'N', 1),
('골드보이 Episode 2', '어둠 속 작은 배우가 세상을 밝히다', '/images/vod/32dfe6e1590eb5dda6205a2a9cd998c1.webp', '5 WoW~', '15', 63, 'N', 1);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('웹뮤지컬 <골드보이> - 메이킹 필름', '케미까지 빛나는 아티스트들의 비하인드!', '/images/vod/86c3a8eb6d9d592cdc71b604225a83ae.webp', 'FREE', NULL, 41, 'N', 1),
('웹뮤지컬 <골드보이> PLAYLIST', '주요 넘버를 PLAYLIST로 무.한.재.생!', '/images/vod/282dafe8fe2fd185fa6b70b6c569e5a3.webp', 'FREE', NULL, 80, 'N', 1);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('연극 <우리는 논개의 얼굴을 모른다>', '세 명의 논개, 이 중 진짜는 누구인가?', '/images/vod/fc26ab162994e531aa70db4430bf530d.webp', '7 WoW~', 'All', 48, 'N', 2),
('연극 <우리는 논개의 얼굴을 모른다> interview', '<우리는 논개의 얼굴을 모른다> 연출 왕정민 인터뷰', '/images/vod/4d6f48586aa694d5cce3a063333cd258.webp', 'FREE', NULL, 33, 'Y', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('연극 <GOOD DAY TODAY>', '새빨간 거짓말, 들어보시겠어요?', '/images/vod/8c17459a781880a37db384a14b7ab375.webp', '9 WoW~', '12', 60, 'N', 2),
('연극 <무라>', '닮고 싶지 않지만 닮아가는 부모와 자식 사이 ― 무(無)', '/images/vod/93166436a2106fc6dcbd9486b32952a8.webp', '9 WoW~', '12', 55, 'N', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('연극 <찰칵>', '인생 단 한 번, 가장 반짝이는 한 순간의 기록', '/images/vod/a3d96fa4a11af040b6547590b12eb3e8.webp', '9 WoW~', '12', 39, 'N', 2),
('장면을 몸으로 형상화하는 안무감독이 일하는 법', 'OA PLUS+ Vol.1', '/images/vod/d44e79e21d8dec5d5436691e2daa5ac3.webp', '25 WoW~', NULL, 41, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('서로의 영감이 되다, 예술가 삼남매의 기하학적 협업 방식 Vol.1', 'OA PLUS+ Vol.1', '/images/vod/62dbe030aea22bfd6e08e2fc1438ebf9.webp', '25 WoW~', NULL, 49, 'N', 3),
('국제교류 기획자의 필수자질과 역량', 'OA PLUS+ Vol.1', '/images/vod/300549b4b4bfac2d49c037aff58e36fd.webp', '25 WoW~', NULL, 39, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('무용 국제 교류의 중심, 시댄스 페스티벌의 모든 것', 'OA PLUS+ Vol.1', '/images/vod/a00c733f3d7a8492015ca8f3645602a2.webp', '25 WoW~', NULL, 45, 'N', 3),
('[62회 동아음악] 심사위원 인터뷰', '동아음악콩쿠르 심사위원을 만나다', '/images/vod/c236861a73ac9d5efc09c999f024a91a.webp', 'FREE', NULL, 39, 'Y', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[62회 동아음악] 트럼펫 본선 경연 영상', '제62회 동아음악콩쿠르 본선 경연 영상 모음', '/images/vod/9cdcc7e2c8b9283e17bf292e7f777ea5.webp', '12 WoW~', 'All', 63, 'N', 4),
('[62회 동아음악] 트롬본 본선 경연 영상', '제62회 동아음악콩쿠르 본선 경연 영상 모음', '/images/vod/432c4925a1a1260ccfe4f2fd176380da.webp', '12 WoW~', 'All', 57, 'N', 4),
('[62회 동아음악] 비올라 본선 경연 영상', '제62회 동아음악콩쿠르 본선 경연 영상 모음', '/images/vod/ea52ba3829f9d40ada22fb77033a3e6c.webp', '12 WoW~', 'All', 23, 'N', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('뮤지컬 <그대 이름은 장미>', '오합지졸 밴드의 시작', '/images/vod/b38edd3a92860d33b80fa6ac5424fb3c.webp', '9 WoW~', 'All', 27, 'N', 1),
('뮤지컬 <그대 이름은 장미> interview', '<그대 이름은 장미> 제작진 및 배우 인터뷰', '/images/vod/a399dd33218decadeaccfd060fc15add.webp', 'FREE', NULL, 19, 'Y', 1);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('뮤지컬 <백만송이의 사랑>', '어디서든 피어나는 눈부신 사랑', '/images/vod/7ecfd6095d9b5d813976af778ad3d4c3.webp', '9 WoW~', 'All', 92, 'N', 1),
('아찔한 첫 공연의 기억, 나의 첫 공연 제작기', 'OA PLUS+ Vol.1', '/images/vod/a409015785189663eb04cfde40e43d4e.webp', '25 WoW~', NULL, 84, 'N', 1),
('K-콘텐츠의 성공적인 해외 시장 진출 비결', 'OA PLUS+ Vol.1', '/images/vod/a13ecf4ffeb4ca3700170e57da465e86.webp', '25 WoW~', NULL, 12, 'N', 1);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('소외감을 넘어, 회복을 꿈꾸는 연출가 정현준', 'OA PLUS+ Vol.2', '/images/vod/258133d65a77ac9ca36b5878dbf0e4af.webp', '25WoW~', NULL, 21, 'N', 2),
('창작에서의 기술 활용, 새로운 만남', 'OA PLUS+ Vol.2', '/images/vod/b2c1594a45a0a149e7b931e9ae60c0c6.webp', '25WoW~', NULL, 47, 'N', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('연출과 드라마투르그, 다르기에 더 단단한 유대감', 'OA PLUS+ Vol.2', '/images/vod/101e82ee5f2b343d1e16dcc7972dbd16.webp', '25WoW~', NULL, 81, 'N', 2),
('공연 예술과 기술, 그리고 소통의 방식', 'OA PLUS+ Vol.2', '/images/vod/00b3c7e66da92db34928290d1cd1c47e.webp', '25WoW~', NULL, 66, 'N', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('연극 <타자기 치는 남자(2021)>', '간첩 잡는 형사의 뜨거운 문학수업', '/images/vod/6120bebd49195397f067cb7d2177164c.webp', '9 WoW~', '15', 77, 'N', 2),
('연극 <코마>', '어느 날 갑자기 재앙이라는 꼬리를 드리우고 나타나는 별', '/images/vod/ac402c1aad91419c06c04696cde46295.webp', '12 WoW~', '15', 38, 'N', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('연극 <코마> interview', '<코마> 작·연출 김정환 인터뷰', '/images/vod/e10e58c29674e73fbe5c9d60f11e1660.webp', 'FREE', NULL, 30, 'Y', 2),
('코믹스 퍼포먼스 <러커스 더 스쿨>', '넌버벌 퍼포먼스 <JUMP> 이준상 연출가 신작!', '/images/vod/d1995f6943ee8587a3efc3dac70f10e4.webp', '7 WoW~', 'All', 49, 'N', 2),
('코믹스 퍼포먼스 <러커스 더 스쿨> interview', '<러커스 더 스쿨> 연출∙예술감독 이준상, 무술감독∙배우 장군 인터뷰', '/images/vod/24a1ff6d71256c0387e839fa4a41f3a9.webp', 'FREE', NULL, 28, 'Y', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('서로의 영감이 되다, 예술가 삼남매의 기하학적 협업 방식 Vol.2', 'OA PLUS+ Vol.1', '/images/vod/30643b5f07e7dbf7ae5a9d088c27fc5c.webp', '25 WoW~', NULL, 22, 'N', 3),
('[53회 동아무용] 심사위원 인터뷰', '동아무용콩쿠르 심사위원을 만나다', '/images/vod/33e99233b0a99cbbed466c65a4a87070.webp', 'FREE', NULL, 10, 'Y', 3),
('[53회 동아무용] 수상자 인터뷰', '동아무용콩쿠르 수상자 14인을 만나다', '/images/vod/c4801c3cca487dec0b7628c3897e7ad1.webp', 'FREE', NULL, 17, 'Y', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[53회 동아무용] 전체 부문 금상 수상작', '세계로 뻗어나갈 우리 무용 인재들의 빛나는 무대', '/images/vod/502ddf6c6624c46801de6b87e4c745a7.webp', '10 WoW~', 'All', 91, 'N', 3),
('[53회 동아무용] 현대무용 전체 부문 수상작', '세계로 뻗어나갈 우리 무용 인재들의 빛나는 무대', '/images/vod/be21c76f0e46baf3878afa3ee8c574dc.webp', '10 WoW~', 'All', 81, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[53회 동아무용] 현대무용 고등부 본선 진출작', '세계로 뻗어나갈 우리 무용 인재들의 빛나는 무대', '/images/vod/f1dccb213faa193df81ecbc1615eca87.webp', '8 WoW~', 'All', 77, 'N', 3),
('[53회 동아무용] 발레 일반부 본선 진출작', '세계로 뻗어나갈 우리 무용 인재들의 빛나는 무대', '/images/vod/fbd3f803f1235de865b4b14efeb68ff5.webp', '10 WoW~', 'All', 88, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[53회 동아무용] 발레 중등부 본선 진출작 및 수상작', '세계로 뻗어나갈 우리 무용 인재들의 빛나는 무대', '/images/vod/72a51fab5504e803b5d29f42b436478f.webp', '8 WoW~', 'All', 69, 'N', 3),
('[53회 동아무용] 발레 초등부 본선 진출작 및 수상작', '세계로 뻗어나갈 우리 무용 인재들의 빛나는 무대', '/images/vod/f5a3fdfd386c2a7385647f04f29bc3a5.webp', '8 WoW~', 'All', 52, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[62회 동아음악] 호른 본선 경연 영상', '제62회 동아음악콩쿠르 본선 경연 영상 모음', '/images/vod/1772ec7a60fdd15c472db4a2b9ff03bc.webp', '12 WoW~', 'All', 36, 'N', 4),
('[62회 동아음악] 첼로 본선 경연 영상', '제62회 동아음악콩쿠르 본선 경연 영상 모음', '/images/vod/d07554569222294ca045d2e44464d8f2.webp', '12 WoW~', 'All', 40, 'N', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[62회 동아음악] 콘트라베이스 본선 경연 영상', '제62회 동아음악콩쿠르 본선 경연 영상 모음', '/images/vod/792992abea8a3a6c0f8a13f9f67969c9.webp', 'FREE', NULL, 53, 'N', 4),
('[62회 동아음악] 바이올린 본선 경연 영상', '제62회 동아음악콩쿠르 본선 경연 영상 모음', '/images/vod/63f65dd60c07a155c294dc6693225bed.webp', 'FREE', NULL, 50, 'N', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[7회 동아뮤지컬] 초등부·중등부 본선 진출자 축하무대', '슬픔과 걱정을 날려버리는 희망의 목소리, \'When I Grow Up\'', '/images/vod/a9007bbd22e002bb84d1b4146ef5f665.webp', 'FREE', NULL, 15, 'N', 1),
('[7회 동아뮤지컬] 고등부·대학(일반)부 본선 진출자 축하무대', '아쉬움 대신 사랑을 노래하는 따스한 목소리, \'Seasons of Love\'', '/images/vod/205a9ccfd4c51aef19f45a12f432e54f.webp', 'FREE', NULL, 16, 'N', 1);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[7회 동아뮤지컬] 초등부, 중등부 수상자 인터뷰', '동아뮤지컬콩쿠르 수상자 13인을 만나다 - 1', '/images/vod/a8649d9928ca20bc5b3150fa34ff02dd.webp', 'FREE', NULL, 20, 'Y', 1),
('[7회 동아뮤지컬] 고등부, 대학(일반)부 수상자 인터뷰', '동아뮤지컬콩쿠르 수상자 13인을 만나다 - 2', '/images/vod/7c9bd9472c20a3032b2a9517fcc56b2d.webp', 'FREE', NULL, 23, 'Y', 1);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[7회 동아뮤지컬] 심사위원 인터뷰', '동아뮤지컬콩쿠르 심사위원을 만나다', '/images/vod/684db7db285880a8645dc919fccb17f2.webp', 'FREE', NULL, 17, 'Y', 1),
('[7회 동아뮤지컬] 초등부 본선 경연 영상 - 1', '제7회 동아뮤지컬콩쿠르 본선 경연 영상 모음', '/images/vod/4b1c0017dfb36daa909c5b8d9aa83cc1.webp', '8 WoW~', 'All', 35, 'N', 1);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[7회 동아뮤지컬] 초등부 본선 경연 영상 - 2', '제7회 동아뮤지컬콩쿠르 본선 경연 영상 모음', '/images/vod/30e2528ed5b8c8bfe4a7ccdbb956c890.webp', '8 WoW~', 'All', 42, 'N', 1),
('[7회 동아뮤지컬] 중등부 본선 경연 영상', '제7회 동아뮤지컬콩쿠르 본선 경연 영상 모음', '/images/vod/103f454df8eefb616dfbfdb6e4d60945.webp', '8 WoW~', 'All', 34, 'N', 1);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[7회 동아뮤지컬] 고등부 본선 경연 영상', '제7회 동아뮤지컬콩쿠르 본선 경연 영상 모음', '/images/vod/42bccdb5d563f82023f6467482c77622.webp', '8 WoW~', 'All', 27, 'N', 1),
('[7회 동아뮤지컬] 초등부, 중등부 금/은/동상 수상자 경연 영상', '제7회 동아뮤지컬콩쿠르 본선 경연 영상 모음', '/images/vod/89ab26b8782cf3ade5f391cf7942ca7f.webp', '12 WoW~', 'All', 46, 'N', 1);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[7회 동아뮤지컬] 고등부, 대학(일반)부 금/은/동상 수상자 경연 영상', '제7회 동아뮤지컬콩쿠르 본선 경연 영상 모음', '/images/vod/ea74c84d27b1f5f15fa37394eefde653.webp', '12 WoW~', 'All', 42, 'N', 1),
('연극 <돌아오는 火,요일>', '돌고 도는 분노 속, 당신이 마주할 화요일의 모습은', '/images/vod/f8b40dda64399a278d3add5fdc2d3725.webp', '6 WoW~', '12', 88, 'N', 2),
('연극 <돌아오는 火,요일> interview', ' <돌아오는 火,요일> 극작·연출 이흥근 인터뷰', '/images/vod/b64878ebe6dd247220aa59c042a0cd37.webp', 'FREE', NULL, 64, 'Y', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('연극 <유미주의>', '아름다움에 대한 집착이 불러온 비극. \'예쁘다\'는 말 뒤에는 어떤 것이 숨어 있을까?', '/images/vod/1c832ce627d28c817727408831542029.webp', '3 WoW~', 'All', 49, 'N', 2),
('연극 <누에>', '조선 시대 궁궐을 배경으로 펼쳐지는 두 여인의 비극적 운명', '/images/vod/03a17f2f1df70d367379d86fd60a69c5.webp', '10 WoW~', '12', 37, 'N', 2),
('연극 <아는 사람 되기>', '아는 사람이 되면 다른 사람과 함께 (잘) 살아갈 수 있을까?', '/images/vod/1a006d294ff84a225d28fe7845629320.webp', '10 WoW~', '12', 49, 'N', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('연극 <통속소설이 머 어때서?!>', '2024년의 감수성으로 다시 깨어난 1930년대 원조 멜로드라마', '/images/vod/c44d19fbcfe2a9f3cbe3f1b49033016e.webp', '10 WoW~', 'All', 62, 'N', 2),
('[53회 동아무용] 한국무용(창작) 일반부(남자) 본선 진출작', '세계로 뻗어나갈 우리 무용 인재들의 빛나는 무대', '/images/vod/7c711944131fe7cc164339455f9b8e8b.webp', '8 WoW~', 'All', 79, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('[53회 동아무용] 한국무용(창작) 일반부(여자) 본선 진출작', '세계로 뻗어나갈 우리 무용 인재들의 빛나는 무대', '/images/vod/3879e14662085e355e1ae09d061424e6.webp', '8 WoW~', 'All', 74, 'N', 3),
('[53회 동아무용] 한국무용(전통) 전체 부문 수상작', '세계로 뻗어나갈 우리 무용 인재들의 빛나는 무대', '/images/vod/f1c85804cd5cae1e64955d45dd85b898.webp', '10 WoW~', 'All', 69, 'N', 3),
('무용 <ON THE TABLE>', '당신의 식탁은 안전한가요?', '/images/vod/83360c7ccf0c19446040644a2de73285.webp', '14 WoW~', 'All', 84, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('무용 <ON THE TABLE> interview', '<ON THE TABLE> 예술감독 조현상 인터뷰', '/images/vod/9f0ca3ef78ff2466d07b9eb949cb9c12.webp', 'FREE', NULL, 75, 'Y', 3),
('공연예술제를 만들기 위해 꼭 알아야 할 체크리스트', 'OA PLUS+ Vol.2', '/images/vod/3200c921d2012ff6c247da660e330e42.webp', '25 WoW~', NULL, 59, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('예술로 하고싶은 것 다 하는 프로N잡러 되기', 'OA PLUS+ Vol.1', '/images/vod/b2434ac7746825d9908fa0f478fde4b0.webp', '25 WoW~', NULL, 74, 'N', 4),
('지속가능성을 높이는 미국 비영리 예술기관의 운영방식', 'OA PLUS+ Vol.1', '/images/vod/8d2fd41b0d0606f76bc6e8da2ef5fdf9.webp', '25 WoW~', NULL, 60, 'N', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('품아트컴퍼니 <군함의 자태>', '제30회 창무국제공연예술제 참여작', '/images/vod/397ec66e605a0f0f6aa52a0a909e5419.webp', '10 WoW~', 'All', 76, 'N', 3),
('이민규 <그 강>', '제30회 창무국제공연예술제 참여작', '/images/vod/843b4825d590957f3e9f5bbaa163a7ba.webp', '3 WoW~', 'All', 60, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('전복된 해부학적 풍경(SAL) <88>', '제30회 창무국제공연예술제 참여작', '/images/vod/1db95fb9d77515d47156c414ebe0f77a.webp', '10 WoW~', 'All', 43, 'N', 3),
('DAN ART COMPANY <마음은 계절이고, 시작은 유서였다>', '제30회 창무국제공연예술제 경연작', '/images/vod/a472d0a693ebe756ff4936e54159989d.webp', '4 WoW~', 'All', 84, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('EK Dance Project <Another silhouette>', '제30회 창무국제공연예술제 경연작', '/images/vod/cbe6967c677eb693f7d6fc84b43f260b.webp', '5 WoW~', 'All', 72, 'N', 3),
('진현실(서울교방) <밀어(密語)>', '제30회 창무국제공연예술제 경연작', '/images/vod/c35d69a51baaceb45f70e7b1bfde4142.webp', '4 WoW~', 'All', 58, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('댄스플랜 홍은주무용단 <경계의 순간들>', '제30회 창무국제공연예술제 경연작', '/images/vod/85e02519b3cdcf7726112812782ac3b7.webp', '4 WoW~', 'All', 49, 'N', 3),
('오키도우젠카구라보존회 <隠岐島前神楽(오키도우젠카구라)>', '제30회 창무국제공연예술제 참여작', '/images/vod/e3d244aac26d3724c231e6265ebbfdad.webp', '10 WoW~', 'All', 37, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('R.se dC(르씨 디씨) <MOB>', '제30회 창무국제공연예술제 참여작', '/images/vod/f12a2a3c00f0cdad5c3ce48d01ac22b1.webp', '10 WoW~', 'All', 22, 'N', 3),
('Niek Wagenaar’s Nymphs(니크 바게나르) <After All(결국)>', '제30회 창무국제공연예술제 참여작', '/images/vod/7a8edf66a9465e39cdb95a1cc89e1eb6.webp', '10 WoW~', 'All', 15, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('김미란 댄스시어터 엇 <중中독 - 독안의 여자>', '제30회 창무국제공연예술제 참여작', '/images/vod/bef7f8fce5da5dd190d54ff24d84af14.webp', '8 WoW~', 'All', 74, 'N', 3),
('Ephrat Asherie Dance(에프라트 아셰리 댄스) <ODEON(오데온)>', '제30회 창무국제공연예술제 참여작', '/images/vod/a1cffd83e074931a274f46e5276bd002.webp', '10 WoW~', 'All', 43, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('불안감을 공감으로 바꾸는 음악감독 정혜진', 'OA PLUS+ Vol.2', '/images/vod/011a8e3831b84352846c408b42d25210.webp', '25WoW~', NULL, 45, 'N', 1),
('뮤지컬 <마지막 정원>', '불타버린 세상 속 피어난 마지막 희망', '/images/vod/1424013fa7081357eaf17c1fcfc6883b.webp', '9 WoW~', 'All', 73, 'N', 1);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('연극 <SAVE ME(본공연)>', '돈, 비밀, 그리고 생존을 둘러싼 위태로운 줄타기', '/images/vod/3087682896a0fb4690cba8f05cdef540.webp', '8 WoW~', '15', 42, 'N', 2),
('연극 <달.仴(본공연)>', '완벽하게 통제된 디스토피아 속, 통제되지 않는 인간의 욕망과 희망', '/images/vod/5084764c391bd2099880bb2c688cf1ce.webp', '8 WoW~', '12', 37, 'N', 2);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('연극 <우리별 1호(본공연)>', '잊혀진 것들의 귀환을 위해 떠나는 두 생명체의 여정', '/images/vod/d426454a44ab98a61bdf9381041ea98f.webp', '4 WoW~', 'All', 31, 'N', 2),
('연극 <아빠가 이력서를 썼다(본공연)>', '잊혀진 것들의 귀환을 위해 떠나는 두 생명체의 여정', '/images/vod/73c64b0198bb67eef61725fad255d37b.webp', '8 WoW~', 'All', 51, 'N', 2);

INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('연극 <장도>', '잘 산다는 건 도대체 무엇인가?', '/images/vod/33cac6ad0306edc73b36f6eb5a93de2b.webp', 'FREE', NULL, 27, 'N', 2),
('무용 <TOMORROW>', '내일, 더 이상 지구에서 생존할 수 없게 된다면', '/images/vod/e1a2aa3f2104fc5d39453a259ebcd5e0.webp', '7 WoW~', 'All', 50, 'N', 3),
('김미자 <승무(이애주류)>', '전통춤과 창작춤의 상호 접합과 충돌의 측면을 확인할 수 있는 공연 : 8대 중견 춤꾼들의 옛춤 대화', '/images/vod/f5355a4938b99605215e8ba44808095d.webp', '5 WoW~', 'All', 33, 'N', 3);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('박은영 <춘앵전>', '전통춤과 창작춤의 상호 접합과 충돌의 측면을 확인할 수 있는 공연 : 8대 중견 춤꾼들의 옛춤 대화', '/images/vod/501f018a2e0f0ec78d4aa11ff2dfb41c.webp', '6 WoW~', 'All', 48, 'N', 3),
('이미영 <교방굿거리>', '전통춤과 창작춤의 상호 접합과 충돌의 측면을 확인할 수 있는 공연 : 8대 중견 춤꾼들의 옛춤 대화', '/images/vod/b1d67e1efc3785c765265e141e372744.webp', '6 WoW~', 'All', 53, 'N', 3);

INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('손미정 <숨(김매자류 산조)>', '전통춤과 창작춤의 상호 접합과 충돌의 측면을 확인할 수 있는 공연 : 8대 중견 춤꾼들의 옛춤 대화', '/images/vod/62fac1bc95e5d9b30d88578976b2f84b.webp', '20 WoW~', 'All', 92, 'N', 3),
('홍지영 <태평무>', '전통춤과 창작춤의 상호 접합과 충돌의 측면을 확인할 수 있는 공연 : 8대 중견 춤꾼들의 옛춤 대화', '/images/vod/a5c592097c319173ff31a0a757cbf486.webp', '6 WoW~', 'All', 70, 'N', 3),
('영화와 게임에 생동감을 더하는 미디어 음악가 Antonio', 'OA PLUS+ Vol.2', '/images/vod/c3abb10dacf115d8e896456de78679df.webp', '25 WoW~', NULL, 74, 'N', 4);
INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('작곡가로 커리어를 쌓는 노하우', 'OA PLUS+ Vol.2', '/images/vod/7674dc18cfe8fef4c3711dd1b381ce39.webp', '25 WoW~', NULL, 61, 'N', 4),
('새로운 장르를 개척하는 용감, 음악감독 신창렬', 'OA PLUS+ Vol.2', '/images/vod/a112c97baddf462e168a5dd0dded11b4.webp', '25 WoW~', NULL, 48, 'N', 4);

SELECT * FROM vod;

INSERT INTO vod (title, summary, img_url, price, age, favorite, is_interview, category_id) VALUES
('별 헤는 밤', '별 하나에 음악소리', '/images/vod/efc6b8a6193e036cdccb7a95adb49fc7.webp', 'FREE', NULL, 100, 'N', 1),
('뮤지컬 <백만송이의 사랑>', '어디서든 피어나는 눈부신 사랑', '/images/vod/7ecfd6095d9b5d813976af778ad3d4c3.webp', '9 WoW~', 'All', 92, 'N', 1);

-- keyword 데이터 넣기
INSERT INTO keyword_tb(keyword) VALUES
('뮤지컬'), ('SF'), ('여성서사'), ('창·제작'), ('일하는 방식'), ('백스테이지'), ('인사이트'), ('음악/댄스'),
('콩쿠르'), ('예술경영'), ('글로벌'), ('기획·마케팅'), ('쇼뮤지컬'), ('근현대사'), ('가요'), ('휴먼드라마'), ('밴드컬'),
('다문화노동자'), ('어린왕자'), ('판타지'), ('웹뮤지컬'), ('사회적 인식개선'), ('편견'), ('윤동주'), ('관람포인트'), 
('역사적 인물'), ('타임슬립'), ('연극'), ('삶'), ('죽음'), ('역사'), ('전쟁'), ('본공연'), ('사회문제'), ('가족'),
('우주쓰레기'), ('디스토피아'), ('현실비판'), ('트라우마'), ('서울연극제'), ('음악극'), ('옴니버스'), ('사회비판'),
('블랙코미디'), ('코믹스 넌버벌'), ('코믹스 퍼포먼스'), ('범죄스릴러'), ('반전'), ('수상작'), ('트렌드'), ('2인극'),
('감동'), ('3부작'), ('조선시대'), ('비극'), ('고전'), ('리어왕'), ('중국고전'), ('모성애'), ('신체적 연극'),
('재생산'), ('강박'), ('버추얼 휴먼'), ('다큐멘터리 연극'), ('2037년'), ('무용'), ('창무국제공연예술제'), ('전통무용'),
('한국무용'), ('현대무용'), ('카구라'), ('굿'), ('댄스필름'), ('환경문제'), ('SIDance'), ('창작무용'), ('국제교류'),
('발레'), ('경연대회'), ('클래식'), ('바이올린'), ('콘트라베이스'), ('첼로'), ('호른'), ('비올라'), ('트롬본'),
('트럼펫'), ('국악'), ('작곡'), ('아쟁'), ('대금'), ('판소리'), ('해금'), ('피리'), ('정가'), ('거문고'), ('가야금');

SELECT * FROM keyword_tb;


INSERT INTO vod_keyword(vod_id, keyword_id) VALUES
(1,1), (1,26), (1,27), (2,63), (2,64), (2,65), (3,6), (3,7), (3,5), (4,6), (4,7), (4,5), (5,1), (5,19), (5,20),
(6,50), (6,4), (6,6), (7,8), (7,9), (7,79), (8,88), (8,9), (8,97), (9,6), (10,6), (11,8), (11,1), (11,9),
(12,8), (12,1), (12,9), (13,8), (13,1), (13,9), (14,60), (14,61), (14,62), (15,4), (15,6), (15,7),
(16,8), (16,70), (16,78), (17,8), (17,70), (17,76), (18,8), (18,70), (18,76), (19,88), (19,9), (19,96),
(20,88), (20,9), (20,96), (21,88), (21,9), (21,95), (22,88), (22,9), (22,94), (23,88), (23,9), (23,93),
(24,88), (24,9), (24,92), (25,88), (25,9), (25,91), (26,88), (26,9), (26,90), (27,88), (27,9), (27,89),
(28,1), (28,24), (28,25), (29,4), (29,6), (29,7), (30,28), (30,58), (30,59), (31,55), (31,56), (31,57),
(32,4), (32,5), (33,4), (33,50), (33,6), (34,4), (34,5), (34,7), (35,10), (35,5), (35,7), (36,75), (36,76), (36,77),
(37,75), (37,76), (37,77), (38,75), (38,76), (38,77), (39,75), (39,76), (39,77), (40,75), (40,76), (40,77),
(41,80), (41,81), (41,9), (42,80), (42,81), (42,9), (43,80), (43,81), (43,9), (44,80), (44,81), (44,9),
(45,80), (45,81), (45,9), (46,21), (46,22), (46,23), (47,21), (47,22), (47,23), (48,6), (49,6),
(50,26), (50,54), (50,27), (51,6), (51,4), (51,5), (52,51), (52,35), (52,52), (52,53), (53,51), (53,35), (53,52), (53,53),
(54,51), (54,35), (54,52), (54,53), (55,4), (55,5), (56,4), (56,6), (56,5), (57,11), (57,12), (57,5),
(58,11), (58,12), (58,10), (59,6), (59,7), (59,5), (60,80), (60,9), (60,87), (61,80), (61,9), (61,86),
(62,80), (62,9), (62,85), (63,17), (63,16), (63,18), (64,4), (64,5), (64,6), (65,13), (65,14), (65,15),
(66,4), (66,12), (66,10), (67,11), (67,4), (68,4), (68,5), (68,7), (69,50), (69,5), (69,7), (70,4), (70,5), (70,6),
(71,50), (71,5), (71,7), (72,14), (72,28), (72,49), (73,28), (73,47), (73,48), (74,6), (74,4), (74,5),
(75,45), (75,46), (76,6), (76,4), (76,5), (77,4), (77,6), (77,5), (78,6), (78,7), (78,5), (79,6), (79,7),
(80,8), (80,9), (80,79), (81,8), (81,70), (81,76), (82,8), (82,70), (82,76), (83,8), (83,70), (83,78),
(84,8), (84,70), (84,78), (85,8), (85,70), (85,78), (86,80), (86,9), (86,84), (87,80), (87,9), (87,83),
(88,80), (88,9), (88,82), (89,80), (89,9), (89,81), (90,6), (91,6), (92,6), (92,7), (93,6), (93,7), (94,6), (94,7),
(95,8), (95,1), (95,9), (96,8), (96,1), (96,9), (97,8), (97,1), (97,9), (98,8), (98,1), (98,9), (99,8), (99,1), (99,9), 
(100,8), (100,1), (100,9), (101,28), (101,44), (102,6), (102,4), (102,5), (103,28), (103,43), (104,28), (104,40), (104,26),
(105,28), (105,40), (105,42), (106,28), (106,40), (106,41), (107,8), (107,69), (107,76), (108,8), (108,69), (108,76),
(109,8), (109,69), (109,68), (110, 66), (110,74), (110,73), (111,6), (111,4), (111,5), (112,11), (112,5), (112,7),
(113,5), (113,7), (114,11), (114,10), (114,7), (115,66), (115,67), (115,70), (116,66), (116,67), (116,70),
(117,66), (117,67), (117,70), (118,66), (118,67), (118,70), (119,66), (119,67), (119,70), (120,66), (120,67), (120,69), 
(121,66), (121,67), (121,69), (121,70), (122,66), (122,67), (122,68), (122,71), (123,66), (123,67), (123,70),
(124,66), (124,67), (124,70), (125,66), (125,67), (125,70), (126,66), (126,67), (126,70), (127,6), (127,4), (127,5),
(128,1), (128,2), (128,3), (129,28), (129,33), (129,39), (129,34), (130,28), (130,33), (130,37), (130,38),
(131,28), (131,33), (131,2), (131,36), (132,28), (132,33), (132,34), (132,35), (133,28), (133,29), (133,30), (133,31), (133,32),
(134,66), (134,74), (134,73), (135,66), (135,67), (135,69), (135,68), (136,66), (136,67), (136,69), (136,68),
(137,66), (137,67), (137,68), (137,69), (138,66), (138,67), (138,68), (138,69), (139,66), (139,67), (139,68), (139,69), 
(140,4), (140,5), (140,11), (141,4), (141,5), (141,11), (142,7), (142,4), (142,5);

SELECT * FROM vod_keyword;

-- vod테이블 삭제
DROP TABLE oaset;
-- oaset테이블 생성 
CREATE TABLE oaset (
	oaset_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    price VARCHAR(20) NOT NULL,
    title VARCHAR(50) NOT NULL,
	intro VARCHAR(100) NOT NULL,
    img_url VARCHAR(255) NOT NULL,
    favorite INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT NOW(),
    is_interview CHAR(1) NOT NULL DEFAULT 'N',
    category_id INT NOT NULL
);
DESC oaset;

-- oaset 데이터 넣기
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('255 WoW~', '제38회 동아국악콩쿠르 본선 경연 영상 모음', '한국스러움의 맥을 잇는 젊은 국악인들의 꿈의 무대', '/images/oaset/fc5985bf045888542064a90afb80a1e4.webp', 24, 'N', 4);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('63 WoW~', '제38회 동아국악콩쿠르 본선 경연 영상 모음(기관/단체용)', '한국스러움의 맥을 잇는 젊은 국악인들의 꿈의 무대', '/images/oaset/86868083121c0aebcee7b93be3535f56.webp', 53, 'N', 4);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('200 WoW~', '제52회 동아무용콩쿠르 본선 진출작 모음(기관/단체용)', '무용인들의 꿈이 시작되는 ‘치열하지만 가장 유려한’ 무대', '/images/oaset/0f00114eefd37b5ccf97665b7012d57b.webp', 31, 'N', 3);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('49 WoW~', '제52회 동아무용콩쿠르 본선 진출작 모음', '무용인들의 꿈이 시작되는 ‘치열하지만 가장 유려한’ 무대', '/images/oaset/19fee57baa5a6abdbead8e01e332399f.webp', 66, 'N', 3);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('200 WoW~', '제6회 동아뮤지컬콩쿠르 본선 경연 영상 모음(기관/단체용)', '뮤지컬을 향한 열정의 무대가 지금 시작된다', '/images/oaset/d215cb0ba0fab44936da0f3aa4477ce1.webp', 44, 'N', 1);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('49 WoW~', '제6회 동아뮤지컬콩쿠르 본선 경연 영상 모음', '뮤지컬을 향한 열정의 무대가 지금 시작된다', '/images/oaset/f6872d4a6dfd65130a4c1095ed32c650.webp', 13, 'N', 1);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('200 WoW~', '제17회 서울국제음악콩쿠르 결선 경연 영상 모음(기관/단체용)', '음악, 그 세기의 무대가 서울에서 펼쳐진다', '/images/oaset/51cd85834dd5a3d0ef1ab049d7002d39.webp', 33, 'N', 4);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('56 WoW~', '제17회 서울국제음악콩쿠르 결선 경연 영상 모음', '음악, 그 세기의 무대가 서울에서 펼쳐진다', '/images/oaset/9d8e57a2a8932c60925fc9fe08f6b383.webp', 72, 'N', 4);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('200 WoW~', '제62회 동아음악콩쿠르 본선 경연 영상 모음(기관/단체용)', '꿈나무 연주자들의 도전의 무대가 시작된다', '/images/oaset/986ee7c88a984dcb0880d712c21c57de.webp', 61, 'N', 4);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('56 WoW~', '제62회 동아음악콩쿠르 본선 경연 영상 모음', '꿈나무 연주자들의 도전의 무대가 시작된다', '/images/oaset/ede9393577db817f3c97fab332918a30.webp', 50, 'N', 4);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('200 WoW~', '제53회 동아무용콩쿠르 본선 진출작 모음(기관/단체용)', '세계로 뻗어나갈 우리 무용 인재들의 빛나는 무대', '/images/oaset/35dbbb7e30352d54b00dae2479c7c9ca.webp', 25, 'N', 3);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('49 WoW~', '제53회 동아무용콩쿠르 본선 진출작 모음', '세계로 뻗어나갈 우리 무용 인재들의 빛나는 무대', '/images/oaset/cb161bc8faa6b3137d7a9962be2690b7.webp', 39, 'N', 3);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('200 WoW~', '제7회 동아뮤지컬콩쿠르 본선 진출작 모음(기관/단체용)', '뮤지컬 샛별을 위한 꿈의 무대가 펼쳐진다', '/images/oaset/4791c5262a25c78de5032b4644739070.webp', 52, 'N', 1);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('49 WoW~', '제7회 동아뮤지컬콩쿠르 본선 진출작 모음', '뮤지컬 샛별을 위한 꿈의 무대가 펼쳐진다', '/images/oaset/d9921f8fc0707f210fb5eba554e8fcfd.webp', 40, 'N', 1);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('22 WoW~', '극단 즉각반응 연극 \'떠돔 3부작\'', '<GOOD DAY TODAY>, <무라>, <찰칵>을 한 번에', '/images/oaset/86b9602b0eae0b114eb6f57e7c9a2d4c.webp', 60, 'N', 2);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('40 WoW~', '해외진출을 꿈꾸는 용감한 예술가라면', '오아플러스 큐레이션', '/images/oaset/4e405daa10ffb5153519ebdb5939355c.webp', 58, 'N', 1);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('50 WoW~', '자신감을 갖고 싶은 신진 예술가라면', '오아플러스 큐레이션', '/images/oaset/9a42b0b35ff69a941a7c2cf739f724a2.webp', 81, 'N', 2);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('50 WoW~', '작업에 깊이감을 더할 노하우를 원한다면', '오아플러스 큐레이션', '/images/oaset/9ac8753d2b9e7d4e0aac6bdee651f238.webp', 77, 'N', 1);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('180 WoW~', '오아플러스 모든 영상 저렴하게 오랫동안 관람하기', '오아플러스 큐레이션', '/images/oaset/d5921fa761fed40e4a5f71ccf500aba9.webp', 63, 'N', 3);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('50 WoW~', '내 작품으로 세상과 교감하고 싶다면', '오아플러스 큐레이션', '/images/oaset/c8b03d922c6cc094a37ae8aa1f0521de.webp', 31, 'N', 4);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('62 WoW~', '한 줄의 문장이 무대가 되기까지, 연극·뮤지컬 창작', '오아플러스 큐레이션', '/images/oaset/4bedd04bbf213c0349a665f9e0455b9d.webp', 56, 'N', 2);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('62 WoW~', '한 칸의 예술,극공작소 마방진의 작품과 노하우', '오아플러스 큐레이션', '/images/oaset/0c8a0ff16079ed663d972ea1444b9692.webp', 47, 'N', 1);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('62 WoW~', '창작 과정을 탄탄하게! 작품의 내실을 다지는 프로의 내공', '오아플러스 큐레이션', '/images/oaset/d6e36815105ac8aa68fbe5577ee34d39.webp', 19, 'N', 3);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('75 WoW~', '내 작품을 만든다는 것, 신진예술가들의 용감한 작업', '오아플러스 큐레이션', '/images/oaset/c49efa14627786f556bd8508ed895c91.webp', 48, 'N', 4);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('60 WoW~', '새롭게 추가된 신선한 감이 궁금하다면', '오아플러스 큐레이션', '/images/oaset/90fa7bb135c83b08fecc02e654206a7a.webp', 39, 'N', 4);
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('62 WoW~', '아트앤테크, 내 작품에 한끗을 더하는 기술 활용', '오아플러스 큐레이션', '/images/oaset/dd083f94c67edececf526611a4e48d14.webp', 53, 'N', 2);

INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('39 WoW~', '지구를 지켜줘 SET', '환경의 날 오아 큐레이션', '/images/oaset/bc60a5ffa089c655af4b28de040745f3.webp', 86, 'N', 3);

-- 여기부터
INSERT INTO oaset(price, title, intro, img_url, favorite, is_interview, category_id) VALUES
('30 WoW~', '작업에 새로운 영감이 필요하다면', '오아플러스 큐레이션', '/images/oaset/db23bca867b64569178d6043acbf149e.webp', 70, 'N', 1);

SELECT * FROM oaset;

-- view 테이블 삭제
DROP VIEW vod_oaset;
-- vod 랑 oaset 합칠 가상테이블 view 만들기
CREATE VIEW vod_oaset AS
SELECT vod_id, NULL AS oaset_id, title, summary, img_url, price, age, favorite, created_at, is_interview, category_id, NULL AS intro, 'vod' AS source
FROM vod
UNION ALL
SELECT NULL AS vod_id, oaset_id, title, NULL AS summary, img_url, price, NULL AS age, favorite, created_at, is_interview, category_id, intro, 'oaset' AS source
FROM oaset;

SELECT * FROM vod_oaset;


SELECT v.*, k.keyword FROM vod_oaset v LEFT JOIN(
            SELECT vod_keyword.vod_id, JSON_ARRAYAGG(keyword_tb.keyword) keyword FROM vod_keyword
            JOIN keyword_tb ON vod_keyword.keyword_id = keyword_tb.keyword_id
            GROUP BY vod_keyword.vod_id
            ) k ON v.vod_id = k.vod_id
            WHERE v.title LIKE '%동아%' OR
				v.summary LIKE '%동아%' OR
				k.keyword LIKE '%동아%';

