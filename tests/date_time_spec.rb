require_relative '../models/date_time'

describe DateTime do
  
  it "should return 0 hours, 0 minutes, 0 seconds for 0 input fraction" do
    fraction = DateTime.toDayFraction(0)
    fraction[:hours].should equal 0
    fraction[:minutes].should equal 0
    fraction[:seconds].should equal 0
  end

  it "should return 12 hours, 0 minutes, 0 seconds for 0.5 input fraction" do
    fraction = DateTime.toDayFraction(0.5)
    fraction[:hours].should equal 12
    fraction[:minutes].should equal 0
    fraction[:seconds].should equal 0
  end

  it "should return 36 hours, 0 minutes, 0 seconds for 1.5 input fraction" do
    fraction = DateTime.toDayFraction(1.5)
    fraction[:hours].should equal 36
    fraction[:minutes].should equal 0
    fraction[:seconds].should equal 0
  end

  it "should return 42 hours, 5 minutes, 17 seconds for 1.753628 input fraction" do
    fraction = DateTime.toDayFraction(1.7536)
    fraction[:hours].should equal 42
    fraction[:minutes].should equal 5
    fraction[:seconds].should equal 11
  end
  
end