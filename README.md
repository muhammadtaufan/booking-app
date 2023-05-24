# README

# Booking App
Simple Rails API to create reservation from various third parties payload request

## Getting Started
### Prerequisites
```sh
Ruby version 3.0.0
Rails version 7.0.4
```

### Installing

- Clone the repo
```sh
git clone https://github.com/muhammadtaufan/booking-app.git
```

- Install dependencies & Migration

```sh
bundle install

cp config/application.yml.sample config/application.yml

rails db:setup db:migrate
```

### Usage
#### Run the server

```sh
rails s
```

#### Run the test

```sh
rspec
```

### API

#### Create a reservation

#### Partner A
```sh
curl --location 'http://localhost:3000/v1/reservations' \
--header 'Content-Type: application/json' \
--data-raw '{
    "reservation_code": "YYY12345678",
    "start_date": "2021-04-14",
    "end_date": "2021-04-18",
    "nights": 10,
    "guests": 4,
    "adults": 2,
    "children": 2,
    "infants": 0,
    "status": "canceled",
    "guest": {
        "first_name": "Wayne",
        "last_name": "Woodbridge",
        "phone": "639123456789",
        "email": "wayne_woodbridge@bnb.com"
    },
    "currency": "AUD",
    "payout_price": "4200.00",
    "security_price": "500",
    "total_price": "4700.00"
}'
```

#### Partner B
```sh
curl --location 'http://localhost:3000/v1/reservations' \
--header 'Content-Type: application/json' \
--data-raw '{
    "reservation": {
        "code": "XXX12345678",
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "expected_payout_amount": "3800.00",
        "guest_details": {
            "localized_description": "4 guests",
            "number_of_adults": 2,
            "number_of_children": 2,
            "number_of_infants": 0
        },
        "guest_email": "wayne_woodbridge@bnc.com",
        "guest_first_name": "Wayne",
        "guest_last_name": "Woodbridge",
        "guest_phone_numbers": [
            "639123456789",
            "639123456789"
        ],
        "listing_security_price_accurate": "500.00",
        "host_currency": "AUD",
        "nights": 4,
        "number_of_guests": 4,
        "status_type": "cancel",
        "total_paid_amount_accurate": "4300.00"
    }
}'
```
