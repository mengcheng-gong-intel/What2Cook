echo starting node1
cockroach start --insecure --store=node1 --listen-addr=0.0.0.0:26257 --http-addr=0.0.0.0:8080 --join=0.0.0.0:26257,0.0.0.0:26258,0.0.0.0:26259 --background

echo starting node2
cockroach start --insecure --store=node2 --listen-addr=0.0.0.0:26258 --http-addr=0.0.0.0:8081 --join=0.0.0.0:26257,0.0.0.0:26258,0.0.0.0:26259 --background

echo starting node3
cockroach start --insecure --store=node3 --listen-addr=0.0.0.0:26259 --http-addr=0.0.0.0:8082 --join=0.0.0.0:26257,0.0.0.0:26258,0.0.0.0:26259 --background

# echo starting node4
# cockroach start --insecure --store=node4 --listen-addr=0.0.0.0:26260 --http-addr=0.0.0.0:8083 --join=0.0.0.0:26257,0.0.0.0:26258,0.0.0.0:26259 --background

# echo starting node5
# cockroach start --insecure --store=node5 --listen-addr=0.0.0.0:26261 --http-addr=0.0.0.0:8084 --join=0.0.0.0:26257,0.0.0.0:26258,0.0.0.0:26259 --background

echo initialize the cluster...
cockroach init --insecure --host=0.0.0.0:26257

echo RUN COMMAND cockroach sql --insecure --host=0.0.0.0:26257