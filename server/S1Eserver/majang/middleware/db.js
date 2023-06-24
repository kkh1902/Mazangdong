const mysql = require("mysql2/promise");

const pool = mysql.createPool({
    host: "3.37.141.159",
    user: "user2",
    password: "1111",
    port: 53704,
    database: "majangdongdb",
});

module.exports = pool;