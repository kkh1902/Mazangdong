const express = require("express");
const router = express.Router();
const http = require("http")
const axios = require('axios');

//명세서
// {
//     "home":{"x": 127.0289, "y":37.4971},
//     "trip": ["서울특별시 종로구 율곡로 99 (와룡동)"],
//     "busChk" : 0
// }

//ODsay에서 IP주소 붙혀넣어야함

// 주소 -> 경도 위도 변환 함수
async function getAddressCoordinates(address){
	
	// NAVER KEY
    const clientId = '5rlnenpob5';
    const clientSecret = 'hfBtOXZZ91zS3a6dNSQsY8ehTXZHoDwC89ldERqF';
	
	try{
		
		//출발장소 주소 -> 경도위도 변환
		const road = await axios.get('https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode', {
		  params: {
			query: address,
		  },
		  headers: {
			'X-NCP-APIGW-API-KEY-ID': clientId,
			'X-NCP-APIGW-API-KEY': clientSecret,
		  },
		});
		return {
			
			x: road.data.addresses[0].x, 
			y: road.data.addresses[0].y
			
			   };
		
	} catch(error) {
		
		console.log(error)
		
	}
}


// 경로찾기 함수
async function getFindRoad(start, end, busChk){
	
	// ODsay KEY
	const apiKey = 'hvtVh2422VhUGUcAiMKB5R2aLPxNm5EgNdXPdbcyc/w'
	let url;
	
	try{
		
		// 버스포함경로
		if (busChk === 1){
			
			url = `https://api.odsay.com/v1/api/searchPubTransPathT?SX=${start.x}&SY=${start.y}&EX=${end.x}&EY=${end.y}&apiKey=${apiKey}&OPT=0`;
			
		} else { // 버스없는경로
			
			url = `https://api.odsay.com/v1/api/searchPubTransPathT?SX=${start.x}&SY=${start.y}&EX=${end.x}&EY=${end.y}&apiKey=${apiKey}&OPT=0&SearchPathType=1`;
		}
		
		const response = await axios.get(url);
		const result = response.data.result.path[0].subPath
		// console.log(result[1].lane)
		
		// 가공
		const way = []
		for (var j = 0; j < result.length; j++){
			
			if (result[j].trafficType === 3){
				
				if (way.length === 0){
					way.push({type : "도보 또는 택시", num :"none" ,time : result[j].sectionTime, distance : result[j].distance, sx : start.x, sy : start.y, ex : result[j+1].startX, ey: result[j+1].startY})
				} else if (j === result.length-1){
					way.push({type : "도보 또는 택시", num :"none" ,time : result[j].sectionTime, distance : result[j].distance, sx : result[j-1].endX, sy : result[j-1].endY, ex : end.x, ey: end.y})
				} else {
					way.push({type : "도보 또는 택시", num :"none" ,time : result[j].sectionTime, distance : result[j].distance, sx : result[j-1].endX, sy : result[j-1].endY, ex : result[j+1].startX, ey: result[j+1].startY})
				}
				
			} else if (result[j].trafficType === 2) {
				way.push({type : "버스", num : result[j].lane[0].busNo + '번', time : result[j].sectionTime, distance : result[j].distance, startName : result[j].startName, endName : result[j].endName, sx : result[j].startX, sy : result[j].startY, ex : result[j].endX, ey : result[j].endY})
			} else if (result[j].trafficType === 1) {
				way.push({type : "지하철", num : result[j].lane[0].name, time : result[j].sectionTime, distance : result[j].distance, startName : result[j].startName, endName : result[j].endName, sx : result[j].startX, sy : result[j].startY, ex : result[j].endX, ey : result[j].endY})
			}
		}
		
		return way
		
	}catch(error){
		
		console.log(error)
		
	}
}


// 받은 관광지 경로(길찾기) 생성
router.post('/', async(req,res) => {
	
	// const { home, trip, busChk } = req.body; 시작위치 포함
	const { trip, busChk } = req.body; //시작위치 비포함
	// console.log("find_info", home, trip, busChk)
	console.log(trip)
	console.log(busChk)
	
	try{
		
		// 위도경도 담을 배열
		const location = []
		// 출발 위치 삽입
		// location.push(home) //시작위치넣음
		// 위도 경도 구하기
		for(var i = 0; i < trip.length; i++){
			const result = await getAddressCoordinates(trip[i])
			location.push(result)
			
		}
		
		// 여행 마지막 동선 후 출발지로 이동하기 위한 추가
		// location.push(home) //다시 집가는경로
		// 경로담을 배열
		const road = []
		// 경로구하기
		for(var k = 0; k < location.length-1; k++){
			
			const result = await getFindRoad(location[k], location[k+1], busChk)
			road.push(result)
			
		}
		
		res.status(200).json(road)
	}catch(error){
		
		console.log(error)
		
	}
});

module.exports = router;