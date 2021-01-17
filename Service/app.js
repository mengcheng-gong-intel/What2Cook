const http = require('http');
var async = require('async');
var fs = require('fs');
var pg = require('pg');

const hostname = '0.0.0.0';
const port = 8000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  dbCall();
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World');
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

function dbCall() {
  var config = {
    user: 'root',
    host: 'localhost',
    database: 'what2cook_dev',
    port: 26257,
    // ssl: {
    //     ca: fs.readFileSync('certs/node.crt')
    //         .toString()
        // key: fs.readFileSync('certs/client.mengcheng.key')
        //     .toString(),
        // cert: fs.readFileSync('certs/client.mengcheng.crt')
        //     .toString()
//   }
};

// Create a pool.
var pool = new pg.Pool(config);

pool.connect(function (err, client, done) {

    // Close communication with the database and exit.
    var finish = function () {
        done();
        process.exit();
    };

    if (err) {
        console.error('could not connect to cockroachdb', err);
        finish();
    }
    async.waterfall([
            // function (next) {
            //     // Create the 'accounts' table.
            //     client.query('CREATE TABLE IF NOT EXISTS accounts (id INT PRIMARY KEY, balance INT);', next);
            // },
            // function (results, next) {
            //     // Insert two rows into the 'accounts' table.
            //     client.query('INSERT INTO accounts (id, balance) VALUES (1, 1000), (2, 250);', next);
            // },
            function (results, next) {
                // Print out account balances.
                client.query('SELECT * FROM foods;', next);
            }
        ],
        function (err, results) {
            if (err) {
                console.error('Error inserting into and selecting from accounts: ', err);
                finish();
            }

            console.log('Initial balances:');
            results.rows.forEach(function (row) {
                console.log(row);
            });

            finish();
        });
});
}