set -u # or set -o nounset
: "$VERSION"
: "$ACCESS_TOKEN"

echo $ACCESS_TOKEN | docker login ghcr.io --username shanti-jangam --password-stdin
docker push ghcr.io/shanti-jangam/prime-service:$VERSION