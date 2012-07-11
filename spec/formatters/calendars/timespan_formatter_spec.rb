# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe TimespanFormatter do

  describe "#format" do
    let(:formatter) { TimespanFormatter.new(:locale => :de) }

    describe "#ago" do
      it "works for a variety of units" do
        formatter.format(-3273932, :unit => :year).should match_normalized('Vor 0 Jahren')
        formatter.format(-3273932, :unit => :month).should match_normalized('Vor 1 Monat')
        formatter.format(-3273932, :unit => :week).should match_normalized('Vor 5 Wochen')
        formatter.format(-3273932, :unit => :day).should match_normalized('Vor 37 Tagen')
        formatter.format(-3273932, :unit => :hour).should match_normalized('Vor 909 Stunden')
        formatter.format(-3273932, :unit => :minute).should match_normalized('Vor 54565 Minuten')
        formatter.format(-3273932, :unit => :second).should match_normalized('Vor 3273932 Sekunden')
      end
    end

    describe "#until" do
      it "works for a variety of units" do
        formatter.format(3273932, :unit => :year).should match_normalized('In 0 Jahren')
        formatter.format(3273932, :unit => :month).should match_normalized('In 1 Monat')
        formatter.format(3273932, :unit => :week).should match_normalized('In 5 Wochen')
        formatter.format(3273932, :unit => :day).should match_normalized('In 37 Tagen')
        formatter.format(3273932, :unit => :hour).should match_normalized('In 909 Stunden')
        formatter.format(3273932, :unit => :minute).should match_normalized('In 54565 Minuten')
        formatter.format(3273932, :unit => :second).should match_normalized('In 3273932 Sekunden')
      end
    end
  end
end