require 'spec_helper'

describe ApplicationHelper do

  describe :full_title do
    subject { full_title "foo" }
    it { should =~ /foo/ }
    it { should =~ /^Mein.Programm/ }
  end
  
  describe :distance_of_time_in_words do
    subject { distance_of_time_in_words(1.hour.ago, Time.now) }
    it { should eq "etwa eine Stunde" }
  end
  
end