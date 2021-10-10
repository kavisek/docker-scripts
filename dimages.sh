# Remove all Images
ids=$(docker images | grep -v "docker\|k8s.gcr.io\|REPOSITORY" | awk '{print $3}')
for id in $ids
do
  echo "removing image: $id"
  docker rmi $id
done

# Docker prune all dangling images
docker image prune -a -f

echo "docker images destroyed."
