Pre-requisites
--------------

* Ruby 1.9.3
* Redis Server [download here](http://redis.io/)

Running
-------

`./configure`  
`make`

Make
----

**make** or **make server**  
  Runs Thin server in production mode (Captcha enabled)

**make server-benchmark**  
	Runs Thin server in benchmark mode (Captcha disabled)

**make specs**  
	Runs the RSpec tests

**make kill**  
	Shutdowns Thin server

**make kill-redis**  
	Shutdowns Redis server

Running manually
----------------

1. Download redis

    `wget http://redis.googlecode.com/files/redis-2.4.17.tar.gz`

2. Unpack redis

    `tar zxvf redis-2.4.17.tar.gz`

3. Compile redis

    `cd redis-2.4.17`  
    `make`

4. Start redis-server

    `cd src`  
    `./redis-server &`

5. Clone this repository

	`git clone git://github.com/diegossilveira/voting.git`  
	`cd voting`

6. Install required gems

	`gem install bundler`  
	`bundle install`

7. Run

	`rackup config.ru -s thin -E [production|benchmark]`

8. Test

	Just access http://localhost:9292/voting

Environments
------------

* production
* benchmark - use this one in order to skip captcha challenges

URLs
----

* GET  /voting       [Participant selection page]
* POST /voting/:id   [Vote on participant]
* GET  /voting/stats [Get voting statistics]
* GET  /voting/reset [Reset the voting counts]

Testing
-------

Unit tests were implemented using RSpec

	`make specs`