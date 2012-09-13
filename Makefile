all: server
specs:
	rspec ./spec/*_spec.rb
server:
	rackup config.ru -s thin -E production -D --pid rack.pid
server-benchmark:
	rackup config.ru -s thin -E benchmark -D --pid rack.pid
kill:
	if [ -f rack.pid ]; then kill -9 `cat rack.pid` && rm -rf rack.pid; fi
kill-redis:
	if [ -f redis.pid ]; then kill -9 `cat redis.pid` && rm -rf redis.pid; fi
