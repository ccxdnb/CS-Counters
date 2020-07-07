# Cornershop iOS Development Test

## Before you begin
You will need to create a private GitHub repository using the information that we provided in this README and invite as collaborators: @matmartinez, @joaquintmp and @hghinaglia. The correct collaborators will be confirmed in the email that contains this file.

Should you have any questions, please reach joaquin.munoz@cornershopapp.com or hector@cornershopapp.com. Specially if they are related to UI design.

## The test
Create an iOS app for counting things. You'll need to meet high expectations for quality and functionality. It must meet at least the following:

* Add a named counter to a list of counters.
* Increment any of the counters.
* Decrement any of the counters.
* Delete a counter.
* Show a sum of all the counter values.
* Search counters.
* Enable sharing counters.
* Handle batch deletion.
* Persist data back to the server.
* States are important, consider handling each state transition properly.
* Must **not** feel like a learning exercise. Think you’re building this for the App Store.
* Don't build anything that doesn't feel right for iOS.

#### Build this app using the following spec: https://www.figma.com/file/PyfLvIWQss7Ki9lmzeoY9a/Counters-for-iOS

Some other important notes:

* You can use Swift 5 and the latest beta of Xcode.
* SwiftUI is not welcomed yet, avoid it.
* Showing off the capabilities of UIKit and Core frameworks is **essential**.
* Unreliable networks are a thing. State management and error handling is **expected**.
* The app should persist the counter list if the network is not available (i.e Airplane Mode).

Bonus points:

* Don't use any external dependencies.
* Lightweight view controllers (or view-code, if you prefer)
* Showing off some Core Animation knowledge.
* XCTests are good.
* This app could also be used on landscape and/or iPad devices (i.e on split view).

**Remember**: The UI is super important. Should you have any doubts, please reach the team so we can clarify whatever is unspecified.

## Install and start the server

```
$ npm install
$ npm start
```

## API endpoints / examples

The following endpoints are expecting a `Content-Type: application/json`

```
GET /api/v1/counters
[
]

POST { title: "Coffee" } /api/v1/counter
[
	{ id: "adsf", title: "Coffee", count: 0 }
]

POST { title: "Tea" } /api/v1/counter
[
	{ id: "asdf", title: "Coffee", count: 0 },
	{ id: "qwer", title: "Tea", count: 0 }
]

POST { id: "asdf" } /api/v1/counter/inc
[
	{ id: "asdf", title: "Coffee", count: 1 },
	{ id: "qwer", title: "Tea", count: 0 }
]

POST { id: "qwer"} /api/v1/counter/dec
[
	{ id: "asdf", title: "Coffee", count: 1 },
	{ id: "qwer", title: "Tea", count: -1 }
]

DELETE { id: "qwer" } /api/v1/counter
[
	{ id: "asdf", title: "Coffee", count: 1 }
]

GET /api/v1/counters
[
	{ id: "asdf", title: "Coffee", count: 1 },
]
```
---

![Sir Jonathan Paul "Jony" Ive](Jony.jpg)

_"Design it to look like my shit." -J_
