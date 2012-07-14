# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

TwitterCldr.TimespanFormatter = class TimespanFormatter
	constructor: ->
		@tokens = `{{{tokens}}}`
		@time_in_seconds = {
			"second": 1,
			"minute": 60,
			"hour":   3600,
			"day":    86400,
			"week":   604800,
			"month":  2629743.83,
			"year":   31556926
		}

	format: (seconds, options = {}) ->
		direction = if seconds < 0 then "ago" else "until"
		unit = options["unit"]

		if unit is null or unit is undefined or unit is "default"
			unit = this.calculate_unit(Math.abs(seconds))

		number = this.calculate_time(Math.abs(seconds), unit)
		rule = TwitterCldr.PluralRules.rule_for(number)

		strings = (token.value for token in @tokens[direction][unit][rule])
		strings.join("").replace(/\{[0-9]\}/, number.toString())

	calculate_unit: (seconds) ->
		if seconds < 30
			"second"
		else if seconds < 2670
			"minute"
		else if seconds < 86369
			"hour"
		else if seconds < 604800
			"day"
		else if seconds < 2591969
			"week"
		else if seconds < 31556926
			"month"
		else
			"year"

	# 0 <-> 29 secs                                                   # => seconds
	# 30 secs <-> 44 mins, 29 secs                                    # => minutes
	# 44 mins, 30 secs <-> 23 hrs, 59 mins, 29 secs                   # => hours
	# 23 hrs, 59 mins, 29 secs <-> 29 days, 23 hrs, 59 mins, 29 secs  # => days
	# 29 days, 23 hrs, 59 mins, 29 secs <-> 1 yr minus 1 sec          # => months
	# 1 yr <-> max time or date                                       # => years
	calculate_time: (seconds, unit) ->
		Math.round(seconds / @time_in_seconds[unit])
