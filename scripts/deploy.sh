set -u # or set -o nounset
: "$CONTAINER_REGISTRY"
: "$VERSION"
: "$DATASOURCE_URL"
: "$DATASOURCE_UN"
: "$DATASOURCE_PW"

# Create a temporary file
TMP_FILE=$(mktemp)

# Substitute environment variables and write to temporary file
envsubst < ./scripts/kubernetes/deploy.yaml > "$TMP_FILE"

# Apply the Kubernetes configuration
kubectl apply -f "$TMP_FILE"

# Clean up
rm "$TMP_FILE"

kubectl create secret generic postgres-primes-secrets \
  --from-literal=DATASOURCE_URL="jdbc:postgresql://your-db-host:5432/primes" \
  --from-literal=DATASOURCE_USERNAME="admin2024" \
  --from-literal=DATASOURCE_PASSWORD="p4662024!"