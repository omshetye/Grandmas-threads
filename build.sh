#!/bin/bash
set -e

echo "=== Installing dependencies ==="
pip install -r requirements.txt

echo "=== Running migrations ==="
python manage.py migrate

echo "=== Collecting static files ==="
python manage.py collectstatic --noinput

echo "=== Creating superuser if needed ==="
if [[ "$CREATE_SUPERUSER" == "1" ]]; then
  echo "from django.contrib.auth import get_user_model; \
User = get_user_model(); \
User.objects.filter(username='$DJANGO_SUPERUSER_USERNAME').exists() or \
User.objects.create_superuser(username='$DJANGO_SUPERUSER_USERNAME', email='$DJANGO_SUPERUSER_EMAIL', password='$DJANGO_SUPERUSER_PASSWORD')" \
  | python manage.py shell
fi

echo "=== Build completed ==="
