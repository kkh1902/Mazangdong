const express = require("express");
const router = express.Router();

// exports
const pool = require("../../middleware/db");

//명세서
// https://majangdong.run.goorm.site/info?together=1&parking=1&wheelchair=1&restroom=1&region=2

//여행지 설정 및 조회
router.get("/", async (req, res) => {
	
	var info = req.query;
	console.log(info)
	
    try {
		
        var trip = await pool.query("select * from 관광지 where 지역번호 = ? and 주차여부 = ? and 휠체어대여 = ? and 화장실 = ?",[info.region, info.parking, info.wheelchair, info.restroom])
		var lodging = await pool.query("select * from 숙박 where 지역번호 = ? and 주차여부 = ? and 휠체어대여 = ? and 화장실 = ?",[info.region, info.parking, info.wheelchair, info.restroom])
		
    } catch (error) {
		
        console.log(error)
		
    }
	
	console.log("info 실행")
	
	return res.json({
		
		"trip": trip[0],
		"lodging": lodging[0]
		
	})
});

module.exports = router;