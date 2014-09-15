tell application "Microsoft Outlook"
	set theMessage to item 1 of (get current messages)
	set theItem to folder of theMessage
	set containerPath to {subject of theMessage, name of theItem}
	set theAccount to name of account of theMessage
	repeat
		try
			set theItem to container of theItem
			copy name of theItem to end of containerPath
		on error
			exit repeat
		end try
	end repeat
	set last item of containerPath to theAccount
	set AppleScript's text item delimiters to {"/"}
	set pathList to (reverse of containerPath) as text
	display dialog "Path to selected message is:" & return & pathList buttons {"OK"} default button 1
end tell

