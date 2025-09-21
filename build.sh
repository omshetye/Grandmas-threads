#!/bin/bash
# build.sh

# Install dependencies
pip install -r requirements.txt

# Any other setup commands
python manage.py collectstatic --noinput
if [[ $CREATE_SUPERUSER ]];
then
  python manage.py createsuperuser --no-input --email "$DJANGO_SUPERUSER_EMAIL"
fi