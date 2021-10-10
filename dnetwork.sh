# Remove networks
ids=$(docker network ls -q)
for id in $ids
do
  echo "removing network: $id"
  docker network rm id
done

echo "docker networks destroyed."