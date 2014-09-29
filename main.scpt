
update_register("afp://nick@mhq-swupdate.local/MHQ", "/Volumes/MHQ/", "/Volumes/MHQ/Backed Up/Retail Stufff/Current Workflows/")

update_register("afp://nick@002.machq.com/Retail", "/Volumes/Retail/", "/Volumes/Retail/Current Workflows/")

update_register("afp://nick@003.machq.com/Retail", "/Volumes/Retail/", "/Volumes/Retail/Current Workflows/")

on update_register(volume_name, mount_point, destination)
	
	mount_register(volume_name)
	
	sync_workflows(destination)
	
	do shell script "/usr/sbin/diskutil unmount " & mount_point & ";"
	
end update_register

on mount_register(register_volume)
	tell application "Finder"
		try
			mount volume register_volume
		on error
			return "Error mounting " & register_volume & ". Please check network connection."
		end try
	end tell
end mount_register

on sync_workflows(target)
	set source to "/Users/nick/Library/Application Support/Fake/Workflows/"
	try
		do shell script "#!/bin/bash;¬
		 /usr/bin/rsync -a '" & source & "' '" & target & "'"
		
	on error
		return "Error syncronizing " & source & " to " & target & "."
	end try
end sync_workflows
