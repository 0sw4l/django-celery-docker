docker-compose -f prod.yml run --user root --rm --no-deps app python manage.py collectstatic
