#web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
# Procfile
backend: bin/rails s -p 3000 -b 0.0.0.0
frontend: bin/webpack-dev-server