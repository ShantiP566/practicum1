set -u # or set -o nounset
:="$VERSION"

docker build -t ghcr.io/shanti-jangam/prime-service:$VERSION --file ./Dockerfile .