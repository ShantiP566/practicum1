set -u # or set -o nounset
: "$CONTAINER_REGISTRY"
: "$VERSION"
: "$DATASOURCE_URL"
: "$DATASOURCE_UN"
: "$DATASOURCE_PW"

# Create a temporary file for deployment
TMP_DEPLOY_FILE=$(mktemp)

# Create deployment and service YAML without the secret
cat << EOF > "$TMP_DEPLOY_FILE"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prime-service
spec:
  replicas: 1
  selector:
    matchLabels:
      app: prime-service
  template:
    metadata:
      labels:
        app: prime-service
    spec:
      containers:
        - name: prime-service
          image: ${CONTAINER_REGISTRY}/prime-service:${VERSION}
          imagePullPolicy: Always
          envFrom:
            - secretRef:
                name: postgres-primes-secrets
          resources:
            requests:
              memory: "256Mi"
              cpu: "200m"
            limits:
              memory: "512Mi"
              cpu: "500m"
---
apiVersion: v1
kind: Service
metadata:
  name: prime-service
spec:
  selector:
    app: prime-service
  type: LoadBalancer
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8085
EOF

# Create a temporary file for secret
TMP_SECRET_FILE=$(mktemp)

# Create secret YAML
cat << EOF > "$TMP_SECRET_FILE"
apiVersion: v1
kind: Secret
metadata:
  name: postgres-primes-secrets
type: Opaque
stringData:
  DATASOURCE_URL: ${DATASOURCE_URL}
  DATASOURCE_USERNAME: ${DATASOURCE_UN}
  DATASOURCE_PASSWORD: ${DATASOURCE_PW}
EOF

# Apply the configurations
kubectl apply -f "$TMP_SECRET_FILE"
kubectl apply -f "$TMP_DEPLOY_FILE"

# Clean up
rm "$TMP_DEPLOY_FILE"
rm "$TMP_SECRET_FILE"