# https://www.virtualbox.org/manual/ch08.html#vboxmanage-intro
$vmNameBlacklist = @("mission_control_client")

$vmlist = C:\Program` Files\Oracle\VirtualBox\VBoxManage.exe list vms
[array]::Reverse($vmlist)
Write-Host ("Vms found: {0}" -f $vmlist.Count)
$skipStarting = 1
$numStarted = 0
$numberToStart = 4
for ($i = 0; $i -lt $vmlist.Count; $i++) {
	if ($numStarted -lt $numberToStart) {
		$vmlist[$i] -match '\"(.+)"\s+\{(.*)\}'
		$name = $Matches.1
		$vmid = $Matches.2
		Write-Host ("Found VM named {0} with id {1}" -f $name, $vmid)
		if ($vmNameBlacklist.contains($name)) {
			Write-Host ("{0} vm was found in the vm black list, so we are skipping it." -f $name)
		} else {
			Write-Host ("Starting vm with name = {0} and id = {1}" -f $name, $vmid)
			if ($skipStarting -ne 1) {
				# https://www.virtualbox.org/manual/ch07.html#vboxheadless
				$startResult = C:\Program` Files\Oracle\VirtualBox\VBoxManage.exe startvm $vmid --type headless
			} else {
				Write-Host "`$skipStarting is set to 1, so we are not really starting the VM."
			}
		}
		$numStarted++
	} else {
		Write-Host "Breaking out of loop. proper number of VMs started"
		break
	}
}