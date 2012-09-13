require 'sinatra/base'
require 'sinatra/synchrony'
require 'redis'
require 'rack/recaptcha'
require_relative 'models/participant'
require_relative 'models/voting'

class VotingApp < Sinatra::Base
	register Sinatra::Synchrony
	
	# captcha stuff
	use Rack::Recaptcha, :public_key => '6LcoX9YSAAAAAOiSpgpyYPW4xOrouQ45J0_sO1iC', :private_key => '6LcoX9YSAAAAAEgcPMY_bds-bF4gs4yOjpeWgFtU'
	helpers Rack::Recaptcha::Helpers

	# constants
	$VOTING_START_DATE = DateTime.now
	$VOTING_DURATION_IN_DAYS = 2

	# redis client
	$redis = Redis.new(:driver => :ruby)

	configure do
		set :environments, %w{development test production benchmark}
		set :public_folder, File.dirname(__FILE__) + '/assets'
	end

	configure :test, :benchmark do
		Rack::Recaptcha.test_mode!
	end

	get '/voting' do
		erb :index
	end

	get '/voting/reset' do
		Voting.reset
		redirect '/voting'
	end

	get '/voting/stats' do
		@partialResult = Voting.partialResult
		@total = Voting.totalCount
		@perHour = '%.1f' % Voting.votePerHour
		erb :stats
	end

	post '/voting/:id' do
		if not recaptcha_valid?
			redirect '/voting'
		else
			@participant = Participant.byId(params[:id].to_i)
	    	@participant.addVote unless @participant.nil?
	    	@partialResult = Voting.partialResult
	    	@timeToEnd = Voting.timeToEnd
	    	erb :result
	    end
	end

end