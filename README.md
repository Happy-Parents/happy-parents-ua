# Happy Parents webstore
## Project setup
1. Place project credential keys at `config/credentials/`
2. Create DB and run migrations:
* `psql`
* `CREATE ROLE <db_username> SUPERUSER CREATEDB LOGIN PASSWORD '<password>';` (username and password can be found in project credentials by running `rails credentials:edit --environment development)`
* `\q`
* `rails db:create db:migrate db:seed`
