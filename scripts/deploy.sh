set -u # or set -o nounset
: "$CONTAINER_REGISTRY"
: "$VERSION"
: "$DATASOURCE_URL"
: "$DATASOURCE_UN"
: "$DATASOURCE_PW"

# Create a temporary file for the processed YAML
TMP_FILE=$(mktemp)

# Process the YAML file with environment variable substitution
envsubst < ./scripts/kubernetes/deploy.yaml > "$TMP_FILE"

# Apply the processed YAML
kubectl apply -f "$TMP_FILE"

# Clean up
rm "$TMP_FILE"