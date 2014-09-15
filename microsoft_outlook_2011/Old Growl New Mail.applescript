(*
Growl New Mail, for Microsoft Outlook 2011 Mac
By Matt Legend Gemmell ( http://mattgemmell.com/ or @mattgemmell on Twitter)

Based on an Entourage script found on the internet, this Outlook 2011 Mac script will post a Growl ( http://growl.info ) notification whenever you get a new email. To make it work, set up a Rule for All Messages to run this AppleScript file.

More info and instructions are here: http://mattgemmell.com/using-growl-with-microsoft-outlook
*)

-- Register a notification type called "New Mail" with Growl, and enable it.
tell application "Growl"
	set the allNotificationsList to {"New Mail"}
	set the enabledNotificationsList to {"New Mail"}
	register as application ¬
		"Outlook" all notifications allNotificationsList ¬
		default notifications enabledNotificationsList ¬
		icon of application "Microsoft Outlook"
end tell

-- Get a list of all "current messages" in Outlook.
tell application "Microsoft Outlook"
	set theMessages to the current messages
end tell

-- Loop through the messages.
repeat with theMsg in theMessages
	tell application "Microsoft Outlook"
		-- Only Growl about unread messages.
		if is read of theMsg is false then
			set growl to true
			set mysubject to get the subject of theMsg
			set mysender to sender of theMsg
			set mycontent to content of theMsg
			-- Get an appropriate representation of the sender; preferably name, but fall back on email.
			try
				if name of mysender is "" then
					set mysender to address of mysender
				else
					set mysender to name of mysender
				end if
			on error errmesg number errnumber
				try
					set mysender to address of mysender
				on error errmesg number errnumber
					-- Couldn't get name or email; we'll just say the sender is unknown.
					set mysender to "Unknown sender"
				end try
			end try
		else
			-- The message was already read, so we won't bother Growling about it.
			set growl to false
		end if
	end tell
	
	-- Tell Growl to show our "New Mail" notification, with a custom title and description.
	if growl is true then
		tell application "Growl"
			notify with name "New Mail" title "Mail from " & mysender description ("\"" & mysubject & "\"") application name "Outlook" --identifier "New Mail"
			-- If you want multiple notifications to replace each other (i.e. only show one notification at a time, with newer ones replacing the older ones), uncomment the last part of the line above to make Growl coalesce the notifications.
		end tell
	end if
end repeat

