#!/bin/sh

echo "Starting entrypoint script..."

if [ "$DATABASE" = "postgres" ]; then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

# you may want to comment out the database flush and migrate commands in the entrypoint.sh script so they don't run on every container start or re-start
# you can run them manually, after the containers spin up
# docker-compose exec web python manage.py flush --no-input

#python manage.py flush --no-input
#python manage.py migrate

# Execute the command provided as arguments to the script
exec "$@"

# To verify that Postgres is healthy before applying the migrations and running the Django development server
