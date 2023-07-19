# README

This is documentation for flow and technical steps.
This project is still on going, so, update will be made daily or so.

Postman documentation link: [here](https://documenter.getpostman.com/view/536273/2s946icrLR)

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

