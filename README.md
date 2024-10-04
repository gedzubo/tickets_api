# README

## How to run the project

- run the `bundle install` command to install the dependancies
- create a copy of `.example_of_env` file and rename it to `.env` (fill it with database credentials)
- run the `rails db:create` command to create DB tables
- import the SQL file from the original repository (in my case `psql -h localhost -d ticket_api_development -U postgres -f database_structure.sql`)
- run the `rails s` command to run the service.

## Curl commands for available endpoints

### Create a new ticket option

```
curl -H 'Content-Type: application/json' \
      -d '{ "name":"Event","desc":"Event Description", "allocation": 10}' \
      -X POST \
      http://localhost:3000/ticket_options
```

### Get ticket option using ID

```
curl -H 'Content-Type: application/json' http://localhost:3000/ticket_options/38f13ced-8148-4d95-b5f6-28bf66f1eada
```

### Purchase n number of tickets from the ticket option

```
curl -H 'Content-Type: application/json' \
      -d '{ "quantity": 2,"user_id":"38f13ced-8148-4d95-b5f6-28bf66f1eadb"}' \
      -X POST \
      http://localhost:3000/ticket_options/38f13ced-8148-4d95-b5f6-28bf66f1eada/purchases
```