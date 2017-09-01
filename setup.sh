docker-compose build
cp Gemfile myapp/
echo "Run `rails new .` and do NOT overwrite the Gemfile :) then exit"
docker-compose run web bash
cp database.yml myapp/config/database
docker-compose up
