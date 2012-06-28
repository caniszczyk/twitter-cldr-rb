# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Tokenizers
include TwitterCldr::Formatters

module TwitterCldr
  module Js
    module Renderers
      module Calendars

        class TimespanRenderer < TwitterCldr::Js::Renderers::Base
          self.template_file = File.expand_path(File.join(File.dirname(__FILE__), "../..", "mustache/calendars/timespan.coffee"))

          def tokens
            [:ago, :until].inject({}) do |final, direction|
              final[direction] = TimespanTokenizer::VALID_UNITS.inject({}) do |direction_hash, unit|
                direction_hash[unit] = Plurals::Rules.all_for(@locale).inject({}) do |rule_hash, rule|
                  rule_hash[rule] = TimespanTokenizer.new(:locale => @locale).tokens(:direction => direction, :unit => unit, :rule => rule)
                  rule_hash
                end
                direction_hash
              end
              final
            end.to_json
          end

        end

      end
    end
  end
end