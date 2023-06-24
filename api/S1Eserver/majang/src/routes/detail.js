const express = require("express");
const router = express.Router();

// exports
const pool = require("../../middleware/db");

// 관광지 상세 조회
router.get("/:num", async (req,res)=>{

	const { num } = req.params;
	console.log(num)	
	try{
		
		const detail = await pool.query("select * from 관광지 where 관광지번호 = ?", [num]);
		
		res.json(detail[0])
		
	}catch(error){
		
		console.log(error)

	}
})

module.exports = router;