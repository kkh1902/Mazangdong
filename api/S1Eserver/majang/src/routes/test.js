const express = require("express");
const router = express.Router();
const http = require("http")
const axios = require('axios');

// exports
const pool = require("../../middleware/db");


// ODsay 경로찾기 test

//명세서
// {
//     "start":{"x":127.100164, "y":37.513346},
//     "end":{"x":127.047395,"y":37.5472}
// }
router.post('/odsay', async (req, res) => {
	
	const { start, end } = req.body;
	console.log(start, end)
    const apiKey = 'hvtVh2422VhUGUcAiMKB5R2aLPxNm5EgNdXPdbcyc/w'
	
    try {
  	  
  	  const url = `https://api.odsay.com/v1/api/searchPubTransPathT?SX=${start.x}&SY=${start.y}&EX=${end.x}&EY=${end.y}&apiKey=${apiKey}&OPT=0`;
	  const response = await axios.get(url);

	  console.log(response.data); // API 응답 데이터

	  res.status(200).json(response.data.result.path[0].subPath);
		
  	} catch (error) {
	  console.error('API 요청 중 오류가 발생했습니다.', error);
	  res.status(500).json({ message: 'API 요청 중 오류가 발생했습니다.' });
		
	}
});


// 네이버 주소 -> 경도위도 test

// 명세서
// {
//     "address":"서울특별시 종로구 율곡로 99 (와룡동)"
// }
router.post('/naver', async (req, res) => {
	const { address } = req.body;
    console.log(address);
	//네이버
    const clientId = '5rlnenpob5'; // 네이버 API 클라이언트 ID
    const clientSecret = 'hfBtOXZZ91zS3a6dNSQsY8ehTXZHoDwC89ldERqF'; // 네이버 API 클라이언트 시크릿
	  try {
		  
		const road = await axios.get('https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode', {
		  params: {
			query: address,
		  },
		  headers: {
			'X-NCP-APIGW-API-KEY-ID': clientId,
			'X-NCP-APIGW-API-KEY': clientSecret,
		  },
		});
		  
		console.log(road.data.addresses[0].x);
		console.log(road.data.addresses[0].y);
		  
		res.status(200).json({"x":road.data.addresses[0].x, "y":road.data.addresses[0].y});
		  
	  } catch (error) {
		  
		console.error(error);
		res.status(500).json({ error: 'An error occurred while calling the Naver Geocoding API.' });
		  
	  }
});


// 전체 관광지 유효주소 검사 test
router.get('/address', async (req, res) => {
	
	// DB 관광지 주소 전부 조회
	const addresses = await pool.query("select 주소 from 관광지")
	const hotel = await pool.query("select 숙박시설주소 from 숙박")
	
	// 네이버
    const clientId = '5rlnenpob5'; // 네이버 API 클라이언트 ID
    const clientSecret = 'hfBtOXZZ91zS3a6dNSQsY8ehTXZHoDwC89ldERqF'; // 네이버 API 클라이언트 시크릿
	  try {
		  for(var i = 0; i< addresses[0].length; i++){

			const road = await axios.get('https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode', {
			  params: {
				query: addresses[0][i].주소,
			  },
			  headers: {
				'X-NCP-APIGW-API-KEY-ID': clientId,
				'X-NCP-APIGW-API-KEY': clientSecret,
			  },
			});
			  
			console.log(addresses[0][i].주소, road.data.addresses[0].x, road.data.addresses[0].y);
		  }
		res.status(200).json();
			  
	  } catch (error) {
		  
		console.error(error);
		res.status(500).json({ error: 'An error occurred while calling the Naver Geocoding API.' });
		  
	  }
});

module.exports = router;