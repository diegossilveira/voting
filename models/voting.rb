require_relative 'date_time'

class Voting

	def self.reset
		Participant.all.each { |p| p.reset }
	end

	def self.partialResult
		Participant.all.collect { |p| { :id => p.id, :voteCount => p.voteCount } }
	end

	def self.timeToEnd
		DateTime.toDayFraction  ($VOTING_START_DATE + $VOTING_DURATION_IN_DAYS - DateTime.now).to_f
	end

	def self.totalCount
    	Participant.all.map { |p| p.voteCount }.reduce { |total, n| total+=n }
  	end

  	def self.votePerHour
  		hours = self.daysFromBeginning * 24
  		hours = hours > 1 ? hours : 1;
  		self.totalCount / hours
  	end

  	@private

	def self.daysFromBeginning
		(DateTime.now - $VOTING_START_DATE).to_f
	end  	

end