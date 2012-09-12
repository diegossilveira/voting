class Participant

  attr_reader :id, :key, :name

  def initialize(id,name=nil)
    @id = id
    @name = name
    @key = "participant:#{id}:votes"
  end
  
  def reset
    $redis.set(@key, 0)
    self
  end

  def voteCount
    $redis.get(@key).to_i
  end
  
  def addVote
    $redis.incr(@key)
  end
  
  def self.byId(id)
    PARTICIPANTS.find { |p| p.id == id }
  end

  def self.all
    PARTICIPANTS
  end
  
  PARTICIPANTS = [Participant.new(1, "Participante 1"), Participant.new(2, "Participante 2")]

end