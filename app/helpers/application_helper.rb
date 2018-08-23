module ApplicationHelper

	def my_paginate(items)
		will_paginate items, {:previous_label => "<< Previous", :next_label => "Next >>"}
	end

end
