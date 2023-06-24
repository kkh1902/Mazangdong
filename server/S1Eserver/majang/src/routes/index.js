const express = require("express");
const router = express.Router();
const http = require("http")
const axios = require('axios');
const { Client } = require('@googlemaps/google-maps-services-js');

	





// 대중교통

// {
//     "start" : "서울특별시 강남구 선릉역",
//     "end" : "서울특별시 강남구 역삼역"
// }


// 경로 조회 요청 핸들러
router.get('/directions', async (req, res) => {
    try {
      // const { origin, destination, apiKey } = req.query;
	    const origin = "서울특별시 강남구 선릉로100길 1"
	    const destination = "서울특별시 양천구 남부순환로64길 20"
	    const apiKey = 'AIzaSyAeGppBL39EwktdKOxEvlWdq26XKG1Yyq8'

      // Google Directions API에 대한 요청 설정
      const response = await axios.get('https://maps.googleapis.com/maps/api/directions/json', {
        params: {
          origin,
          destination,
          mode: 'transit', // 대중교통 모드 설정
		  transit_mode:'subway',
          key: apiKey,
        },
      });

      const directions = response.data;
	
  	  console.log(directions)
	  
      // EJS 템플릿 렌더링하여 결과 전송
      res.render('directions', { origin, destination, directions, apiKey });
	    
    } catch (error) {
      console.error('Error:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } 
});

module.exports = router;