tell application "System Events"
	tell appearance preferences
		get properties
		set currentValue to dark mode
		if currentValue is false then
    end if
  end tell
end tell

return currentValue
