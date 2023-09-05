echo "Restarting $1"
set -x
docker-compose down $1 && docker-compose up $1 -d
set +x


