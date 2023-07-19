# README

This is documentation for flow and technical steps.
This project is still on going, so, update will be made daily or so.

Postman collection link: [here](https://api.postman.com/collections/536273-0aa08384-0873-4345-ad28-f1b0a2d17a77?access_key=PMAT-01H5QAQJB70TWMF9QE02TKEK7Q)

Postman environment file: [here](https://orange-flare-781069.postman.co/workspace/Team-Workspace~f92a27e8-61f3-4de9-8bb1-014812788622/environment/536273-3dc19101-aacc-4d09-b4fa-09b76496185a)

Heroku app link: [here](https://stark-plateau-63460-64360accc453.herokuapp.com)

Flow:

* User data already exists (no sign up, but theres API module for user manipulation. automatically create wallet on create user)
* Sign in
* Add/subtract money to wallet
* Make transaction on stock
* Logout

The complete expected flow here:

* Sign in (as a user/team)
* Add money to wallet
* See list of stock available
* Buy/sell stock (send email notification)
* See in/out in wallet
* See history transaction
* See list of stock and possible profit
* Share profit to all user (in team only) ??? mm not likely . I still don't understand how team works with stock tho
* Logout

What has not in here:
* Email notification
* See profit
* List of stock available (I don't know should I forward the API with API again, or Frontend can use Latest Highest Price API directly, So I only need to store the ID, key, etc of it)

Technical features what still not here or not completed:
* Unit test
* Email notifier
* Error notifier
* Model repository (Or object service. To return object as a formatter one)
* Consuming Latest highest price API directly in a flow
* Handle all possible errors / human error

