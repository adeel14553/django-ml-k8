#!/bin/sh

echo "Starting entrypoint script..."

if [ "$DATABASE" = "postgres" ]; then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python manage.py flush --no-input
python manage.py migrate

# Execute the command provided as arguments to the script
exec "$@"

# To verify that Postgres is healthy before applying the migrations and running the Django development server