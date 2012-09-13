require 'redis'
require_relative '../models/participant'
require_relative '../models/voting'

describe Voting do

  before(:all) do
    $redis = Redis.new
  end

  after(:all) do
    Voting.reset
  end

  it 'should reset voting' do
    Voting.reset
    Participant.all.each do
      |p| p.voteCount.should equal 0
    end
  end
  
  context 'partial results' do

    it 'should have zero votes when initialized' do
      Voting.reset
      Voting.partialResult.each do
        |hash| hash[:voteCount].should equal 0
      end
    end

    it 'should have correct vote counts' do
      Voting.reset
      pOne = Participant.new(1)
      pTwo = Participant.new(2)

      8.times { pOne.addVote }
      21.times { pTwo.addVote }

      Voting.partialResult[0][:voteCount].should equal 8
      Voting.partialResult[1][:voteCount].should equal 21
    end

  end

  it 'should have correct total vote count' do
    Voting.reset
    pOne = Participant.new(1)
    pTwo = Participant.new(2)

    8.times { pOne.addVote }
    21.times { pTwo.addVote }

    Voting.totalCount.should equal 29
  end
  
end