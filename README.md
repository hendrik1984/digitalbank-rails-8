# README

# Docker
* build and run services: docker compose up -d build

* run 1 services: docker compose up -d db

* check logs for running services : docker compose logs web

* check continues logs for running services : docker compose logs -f web

# Rails
* run rails command via docker: docker compose exec web bin/rails db:create

* verify rails to postgres connection via docker: docker compose exec web bin/rails runner "puts ActiveRecord::Base.connection.active?"docker compose exec web bin/rails runner "puts ActiveRecord::Base.connection.active?"

* restart web via docker: docker compose restart web

# Postgres
* open console via docker: docker compose exec db psql -U digital_bank -d digital_bank_development -c '\conninfo' 