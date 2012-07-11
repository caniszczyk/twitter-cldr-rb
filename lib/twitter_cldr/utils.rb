# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Utils

    autoload :CodePoints, 'twitter_cldr/utils/code_points'

    class << self

      # adapted from: http://snippets.dzone.com/posts/show/11121 (first comment)
      def deep_symbolize_keys(arg)
        case arg
          when Array
            arg.map { |elem| deep_symbolize_keys(elem) }
          when Hash
            Hash[arg.map { |k, v| [k.is_a?(String) ? k.to_sym : k, deep_symbolize_keys(v)] }]
          else
            arg
        end
      end

      def deep_merge!(first, second)
        if first.class == second.class
          if first.is_a?(Hash)
            second.keys.each do |key|
              if second[key].class == first[key].class
                first[key] = deep_merge!(first[key], second[key])
                next
              end
              first[key] = second[key]
            end
            first
          elsif first.is_a?(Array)
            first.clear
            first += second
            first
          else
            second
          end
        end
      end

      def compute_cache_key(*pieces)
        if pieces && pieces.size > 0
          pieces.join("|").hash
        else
          0
        end
      end

    end

  end
end

require 'twitter_cldr/utils/interpolation'