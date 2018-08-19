tell application "System Events"
	tell appearance preferences
		get properties
		set currentValue to dark mode
		if currentValue is false then
			set properties to {dark mode:true}
		else if currentValue is true then
			set properties to {dark mode:false}
		end if
	end tell
end tell
