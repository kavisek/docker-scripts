# Kill all actvite containers
ids=$(docker ps -q)
for id in $ids
do
  echo "killing container: $id"
  docker kill $id
done

# Remove all contaniner
ids=$(docker ps -a -q)
for id in $ids
do
  echo "removing container $id"
  docker rm $id
done

echo "docker containers destroyed."
