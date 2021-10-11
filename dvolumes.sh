# Remove volumes
ids=$(docker volume ls -q)
for id in $ids
do
  echo "removing volume: $id"
  docker volume rm $id
done

echo "docker volumes destroyed."