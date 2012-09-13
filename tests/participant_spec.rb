require 'redis'
require_relative '../models/participant'

describe Participant do

  before(:all) do
    $redis = Redis.new
  end
  
  it 'should have zero votes when initialized' do
    Participant.new(1).reset.voteCount.should equal 0
  end
  
  it 'should increment vote count when vote is received' do
    participant = Participant.new(1).reset
    participant.addVote
    participant.addVote
    participant.voteCount.should equal 2
  end
  
  it 'should keep vote count through initializations' do
    participant = Participant.new(1).reset
    participant.addVote
    participant = Participant.new(1)
    participant.voteCount.should equal 1
  end
  
  it 'should have zero votes when reset' do
    participant = Participant.new(1).reset
    participant.addVote
    participant.addVote
    participant.reset
    participant.voteCount.should equal 0
  end
  
  it 'should have two participants at all' do
    Participant.all.should have_exactly(2).items
  end
  
end