const http = require('http');
var async = require('async');
var fs = require('fs');
var pg = require('pg');

const hostname = '0.0.0.0';
const port = 8000;

const server = http.createServer((req, res) => {

  if (req.url == '/') {
    dbCall();
    res.end('Hello');
  } else {
    let data = '';
    req.on('data', chunk => {
      data += chunk;
    })
    console.log(data);

    res.statusCode = 200;
    // dbCall();
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello World');
}
});


// server.listen(port, hostname, () => {
//   console.log(`Server running at http://${hostname}:${port}/`);
// });


var express = require('express')
var app = express()
var bodyParser = require('body-parser')
var fileupload = require("express-fileupload");
app.use(fileupload({
  limits: {
      fileSize: 1000000 //1mb
  },
  abortOnLimit: true}));


app.use(bodyParser.urlencoded({
  extended: true,
  limit: '50mb',
}));
app.use(bodyParser.json({
  limit: '50mb', 
  extended: true
}))



var foods = [];
// respond with "hello world" when a GET request is made to the homepage
app.post('/foods', function (req, res) {
  console.log(req.body.materials);
  let link = "https://static.wikia.nocookie.net/dota2_gamepedia/images/2/23/Axe_icon.png";

  let result = [
    {
      "id": 1,
      "name":"å°é¸¡ç‚–è˜‘è‡",
      "materials": ["é¸¡è‚‰", "è˜‘è‡"],
      "url": "https://storage.googleapis.com/what2cook/Beef-and-potato.jpg"
    },
    {
      "id": 2,
      "name": "å°ç‚’ç‰›è‚‰",
      "materials": ["ç‰›è‚‰", "è¾£æ¤’"],
      "url": "https://storage.googleapis.com/what2cook/Caesar-Salad.jpg"
    },
    {
      "id": 3,
      "name": "ç•ªèŒ„ç‚’è›‹",
      "materials": ["ç•ªèŒ„", "é¸¡è›‹"],
      "url": "https://storage.googleapis.com/what2cook/Cucumber-and-Onion-Salad.jpg"
    }
  ];
  // res.send(fileName);
  res.json(result)
})



app.post('/upload', (req, res) => {

  console.log(req.body);
  res.json(["abc"]);
  // var file;
  // if(!req.files)
  // {
  //     res.send("File was not found");
  //     return;
  // }
  // file = req.files.FormFieldName;  // here is the field name of the form
  // res.send("File Uploaded");

})

app.get('/', function (req, res) {
  dbCall();
  res.send("done");
})

function base64_encode(file) {
  // read binary data
  var bitmap = fs.readFileSync(file);
  // convert binary data to base64 encoded string
  return new Buffer(bitmap).toString('base64');
}

app.listen(port, () => {
  console.log(`Example app listening at http://${hostname}:${port}`)
})


function dbCall() {
  var config = {
    user: 'root',
    host: hostname,
    database: 'what2cook_dev',
    port: 26257,
    // ssl: {
    //     ca: fs.readFileSync('certs/node.crt')
    //         .toString()
        // key: fs.readFileSync('certs/client.mengcheng.key')
        //     .toString(),
        // cert: fs.readFileSync('certs/client.mengcheng.crt')
        //     .toString()
    // }
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
            function (next) {
                // Print out account balances.
                client.query('with fm as ( select c.food_name, a.food_id, a.material_id, b.material_name from FoodMaterials a join Materials b on a.material_id = b.material_id join Foods c on c.food_id = a.food_id ) select fm.food_name, array_agg(distinct material_name) as materials from fm group by fm.food_name;', next);
            }
        ],
        function (err, results) {

          console.log("no error");
            if (err) {
                console.error('Error inserting into and selecting from accounts: ', err);
                finish();
            }

            console.log('Initial balances:');
            results.rows.forEach(function (row) {
                // console.log(row);
                // foods.append(row);
            });

            finish();
        });
});
}