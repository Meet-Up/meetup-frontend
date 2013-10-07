# meetup-frontend [![Build Status][travis-image]][travis-link]

Frontend web application for Meet-Up.

[travis-image]: https://travis-ci.org/Meet-Up/meetup-frontend.png?branch=master
[travis-link]: https://travis-ci.org/Meet-Up/meetup-frontend

## Setup

The application is using npm, Grunt and bower to build. It also requires compass.

### Node

First of all, install NodeJS

```
$ brew install node.js
```

and install `grunt-cli` and `bower`

```
# npm install -g grunt-cli bower
```

### Ruby and compass

If you already have a working installation of Ruby, just run

```
$ gem install compass
```

otherwise, you can fetch and install everything easily with rvm

```
$ \curl -L https://get.rvm.io | bash -s stable --ruby=2.0.0
$ source .rvm/scripts/rvm
$ gem install compass
 ```

### Installing the application

First, clone the repository

```
$ git clone https://github.com/Meet-Up/meetup-frontend.git
```

and then install the dependencies.

```
$ npm install
$ bower install
```

### Running the application

You can run the application using Grunt

```
$ grunt server
```

and run the tests with

```
$ grunt test
```
