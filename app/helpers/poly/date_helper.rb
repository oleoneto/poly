module Poly
	module DateHelper
		def relative_time_in_words(time)
			"#{distance_of_time_in_words(Time.now, time)}"
		end
	end
end
