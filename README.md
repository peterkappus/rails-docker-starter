#Rails Docker Compose Starter Template

A simple boiler plate for getting started with rails and postgres via docker compose.
Also uses bootstrap and some other goodies. Check the gemfile.


## Getting started

1) Install docker, docker compose, etc.
2) Run `./setup.sh` which does the following:
  - `docker-compose build`
  - Host: `cp Gemfile code/`
  - `docker-compose run web bash`
  - Inside your container: `rails new .`
  - NOTE: do NOT overwrite the Gemfile we copied in. We want our custom gems (e.g. postgres)
  - After exiting, the script will `cp database.yml app/config/database`
  - `docker-compose up` This will set up postgresql

NOTE: you might have to refresh a couple of times while it sets up postgres, etc. Then you should be good to go.

3) visit `http://localhost:3000` on the host
4) Use`docker-compose run web bash` to get into your web container and do railsy stuff (e.g. migrate the database, use the console, run cucumber, etc.)
5) Run `docker-compose down` to cleanly exit the rails server in the web container
