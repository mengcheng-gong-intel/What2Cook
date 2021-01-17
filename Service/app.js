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

// respond with "hello world" when a GET request is made to the homepage
app.post('/foods', function (req, res) {

  let materials = new Set(req.body.materials);
  console.log(req.body);
  var toCook = [];
  dbCall(foods => {
    console.log(foods);
    for(var food of foods) {
      food.id = Number(food.id);
      // console.log(food);
      var canCook = true;
      for (var material of food['materials']) {
        if (!materials.has(material)) canCook = false;
      }
      if (canCook == true) {
        toCook.push(food);
      }

    }
    console.log(toCook);
    res.json(toCook);
    
  });
})

app.listen(port, () => {
  console.log(`Example app listening at http://0.0.0.0:${port}`)
})

function dbCall(callback) {
  var config = {
    user: 'root',
    host: '35.245.76.22',
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

        // process.exit();
    };

    if (err) {
        console.error('could not connect to cockroachdb', err);
        finish();
    }

    async.waterfall([
      function (next) {
        // client.query('select * from foods;' ,next);
        // Print out account balances.
        client.query(`with fm as (
          select c.food_name, c.img_url, a.food_id, a.material_id, b.material_name
          from FoodMaterials a join
              Materials b
              on a.material_id = b.material_id
          join
          Foods c
          on c.food_id = a.food_id
      )
      select fm.food_id as id, fm.food_name as name, fm.img_url as url, array_agg(distinct material_name) as materials from fm
          group by fm.food_name, fm.img_url, fm.food_id;`, next);
        // client.query('with fm as ( select c.food_name, a.food_id, a.material_id, b.material_name from FoodMaterials a join Materials b on a.material_id = b.material_id join Foods c on c.food_id = a.food_id ) select fm.food_name, array_agg(distinct material_name) as materials from fm group by fm.food_name;', next);
    }
        ],
        function (err, results) {
            if (err) {
                console.error('Error inserting into and selecting from accounts: ', err);
                finish();
            }

            // console.log('Initial balances:');
            // results.rows.forEach(function (row) {
            //     console.log(row);
            // });

            callback(results.rows);

            finish();
        });
});
}