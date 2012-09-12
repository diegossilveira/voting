require_relative 'controllers/voting_controller'

$VOTING_START_DATE = DateTime.now
$VOTING_DURATION_IN_DAYS = 2
$redis = Redis.new( :driver => :synchrony )

VotingController.run!