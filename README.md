# Introduction
This is a sample API a bank might use for tracking that status of invoices used for factoring

## System dependencies

ruby 3.2.2
rails 7.0.4.3
sqlite3 3.39.5

Installation instructions may be found here:
https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails

## Database setup
rake db:migrate

## How to run the test suite
`bin/rails test`

## How to run the server
`bin/rails server`

## Example invoice lifecycle

### GET current invoices
curl --request GET \
  --url http://localhost:3000/invoices \
  --header 'Content-Type: application/json'

Should return []

### Create a borrower
curl --request POST \
  --url http://localhost:3000/borrowers \
  --header 'Content-Type: application/json' \
  --data '{"borrower": { "name": "ACME Bank" }}'

### Create a fee
curl --request POST \
  --url http://localhost:3000/fees \
  --header 'Content-Type: application/json' \
  --data '{"fee": { "percentage": 0.02 }}'

### Create an invoice

curl --request POST \
  --url http://localhost:3000/invoices \
  --header 'Content-Type: application/json' \
  --data '{
	"borrower_id": 1, 
	"fee_id": 1, 
	"invoice_number": "ABC123", 
	"amount": 200.0,
	"due_date": "2023-04-28 12:41:12",
	"status": "created", 
	"scan": "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=="
}'

### Move the invoice from "created" all the way to "closed"

#### Move from "created" to "approved"
curl --request PUT \
  --url http://localhost:3000/invoices/1 \
  --header 'Content-Type: application/json' \
  --data '{ "id": 1, "status": "approved" }'

#### Move from "approved" to "purchased"
curl --request PUT \
  --url http://localhost:3000/invoices/1 \
  --header 'Content-Type: application/json' \
  --data '{ "id": 1, "status": "purchased" }'

#### Move from "purchased" to "closed"
curl --request PUT \
  --url http://localhost:3000/invoices/1 \
  --header 'Content-Type: application/json' \
  --data '{ "id": 1, "status": "closed" }'

### GET current invoices again, and notice that total_accrued is now set
curl --request GET \
  --url http://localhost:3000/invoices \
  --header 'Content-Type: application/json'