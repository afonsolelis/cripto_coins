#!/bin/sh
set -e

# If current user is not root, try to run with sudo
if [ "$RAILS_ENV" == "development" ] || [ "$RAILS_ENV" == "test" ]; then
  rm -f /app/tmp/pids/server.pid
fi

if [ "$RAILS_ENV" == "production" ] || [ "$RAILS_ENV" == "staging" ] || [ "$RAILS_ENV" == "demo" ]; then
  bundle exec rake db:migrate:ignore_concurrent
fi

# Seed demo env
if [ "$RAILS_ENV" == "demo" ]; then
  echo "Seeding demo environment..."
  bundle exec rake demo:prime
fi

exec "$@"