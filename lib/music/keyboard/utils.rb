
module Music::Keyboard::Utils
	def highlight(c, if_condition)
		if if_condition
			interval_to_html_class(@intervals, c)
		else
			'note'
		end
	end
end
