class DateTime
	def self.toDayFraction(days)
		hours = days * 24
		minutes = (hours - hours.to_i) * 60
		seconds = (minutes - minutes.to_i) * 60
		{ :hours => hours.to_i, :minutes => minutes.to_i, :seconds => seconds.to_i }
	end
end