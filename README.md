# API back-end project, Car periodic checks.

> This is the back end part of a measurement application, on this specific case the application will measure some periodic checks that can be made to a car.

# API routes and verbs.

- POST /signup

> Creates a new user and a authentication token, the keys needed are:
  - username: string
  - password: string (will get encrypted by the API)
  - email: string
  - role: string (The role will determine the accesibility to some routes)

- POST /auth/login

> Authenticates the user. Keys needed:
  - email
  - password

- GET /car

> Generates a list of all the cars registered by the user. This is accesible to all roles.

- GET /car/:id

> Gets the car with the specificated ID

- POST /car/create

> Creates a new car object under the user. Only available for Admin role. Keys needed:
  - owner: string
  - carModel: string
  - manufacturer: string

- PUT /car/update/:id

> Updates one of the keys of the Car. Only available for admin role. Keys that can be updated:
  - owner
  - carModel
  - manufacturer

- DELETE /car/destroy/:id

> Deletes a car and all it's checks. Only available for admin role.

- GET /car/:car_id/periodic_check

> Generates a list of all the checks related to a particular car. Accesible to all roles.

- GET /car/:car_id/periodic_check/:id

> Gets the specific check for the car with the passed ID.

- POST /checks/create/:car_id

> Creates a checkup for the car. Accesible to all roles. Required keys:
  - mileage: float
  - gasPerformance: float
  - passed: string
  - maintenance: date

- PUT checks/update/:car_id/:id

> Updates the keys of the checkup. Accesible to all roles. Keys that can be updated:
  - mileage
  - gasPerformance
  - passed
  - maintenance

- DELETE checks/destroy/:car_id/:id

> Deletes the checkup pointed by the ID. Accesible to all roles.

## Installation.

- Clone the repository from github.
- Run the following commands:
- bundler install (this will install all the gem dependencies on the gemfile.)
- rails db:migrate (this will generate the migrations necesary for the database.)
- Now you can start the server locally with rails s, or you can acces the live version.
- The app only shows JSON data so you'll need an external sevice like postman to check all the features.

## Built With

- Ruby
- Rails
- Rspec
- FactoryBot
- JWT

## Live Demo



## Author

👤 Andres Felipe Perez Restrepo

- [LinkedIn](https://www.linkedin.com/in/andres-felipe-perez-restrepo/)
-  Github: [@queeksm](https://github.com/queeksm)


## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc

## 📝 License

This project is [MIT](lic.url) licensed.
