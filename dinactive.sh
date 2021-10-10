ids=$(docker container list -f "status=exited" -q)
for id in $ids
do
    echo "removing container: $id"
    docker rm -f $id
done

echo "docker inactive containers destroyed."