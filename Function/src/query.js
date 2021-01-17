const async = require('async');
const pg = require('pg');

const query = (callback) => {
    const config = {
      user: 'root',
      host: '35.245.76.22',
      database: 'what2cook_dev',
      port: 26257,
      // ssl: {
      //     ca: fs.readFileSync('certs/node.crt')
      //         .toString()
      //     key: fs.readFileSync('certs/client.mengcheng.key')
      //         .toString(),
      //     cert: fs.readFileSync('certs/client.mengcheng.crt')
      //         .toString()
      // }
    };

    const pool = new pg.Pool(config);

    pool.connect((err, client, done) => {
        // Close communication with the database and exit.
        const finish = () => {
            done();
        };

        if (err) {
            console.error('could not connect to cockroachdb', err);
            finish();
        }

        console.log('connected');

        async.waterfall([
            (next) => {
                // client.query('select * from foods;' ,next);
                // Print out account balances.
                client.query(
                    `with fm as (
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
            }],
            (err, results) => {
                if (err) {
                    console.error('Error inserting into and selecting from accounts: ', err);
                    finish();
                }
                callback(results.rows);
                finish();
            }
        );
    });
};

module.exports.query = query;
