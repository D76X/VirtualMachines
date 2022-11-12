# https://app.pluralsight.com/course-player?clipId=742dbe9b-3746-45a8-8803-d42f288c6835

$rg = "resource-group"
$vmName = "vm-name"

# get the properties of a VM
Get-AzVM -ResourceGroupName $rg -Name $vmName

# get the properties of a VM# get the property Status of a VM
Get-AzVM -ResourceGroupName $rg -Name $vmName -Status

# CS: Cloud Shell
# CS represents the state of your cloud environment as a file system
# CS may cach the reuslts of commands executed in the session thus use -Force
# to force the shell to execute the command anew
$subName = "subscriptionName"
Get-ChildItem "Azure:/${subName}/VirtualMachines"
Get-ChildItem "Azure:/${subName}/VirtualMachines/${vmName}"

# The following commands 
# 1-make use of the | pipe operator.
# 2-make use of teh -AsJob switch that instruct PS to execute the command as a non-blocking background Job 

# Start & Deprovision a VM
Get-ChildItem "Azure:/${subName}/VirtualMachines/${vmName}" | Start-AzVM -AsJob
# or
Start-AzVM -ResourceGroupName $rg -Name $vmName -AsJob

# CS stop a VM without deprovisioning it and do it on a PS job os that 
# If you do not deprovision a VM then it will incur charges!
Get-ChildItem "Azure:/${subName}/VirtualMachines/${vmName}" | Stop-AzVM -StayProvisioned -Force -AsJob

# Stop & Deprovision a VM
# Simply omit the switch -StayProvisioned to stop & deallocate the VM
Get-ChildItem "Azure:/${subName}/VirtualMachines/${vmName}" | Stop-AzVM -Force -AsJob

# Remove a VM - this stops, deallocates and remove the VM from the subscription
Remove-AzVM -ResourceGroupName $rg -Name $vmName -AsJob
Get-ChildItem "Azure:/${subName}/VirtualMachines/${vmName}" | Remove-AzVM -Force -AsJob

# To Generalize a Windows VM we use sysprep
# sysprep resets the Security Identifiers and other user-based information of the OS
# OOBE = Out Of Box Experience
# the /shutdown switch causes the OS to hutdown BUT it does not shutdown and/or deallocate the VM in Azure
# this must be done manually!
# https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/sysprep--generalize--a-windows-installation?view=windows-11
# -----------------------------------------
# sysprep.exe /generalize /shutdown /oobe
# -----------------------------------------

# The process of Generilization of a Linux VM is labeled Deprovisioning
# The tools used to Deprovision a Linux Machine in Azure is the Azure Linux Agent [waagent]
# the concept and purpose is the same as sysprep
# If the OS of an Linux Azure VM is from the Azure Marketplace then waagent is already installed on them
# If the OS of an Linux Azure VM is NOT from the Azure Marketplace then waagent must be installed on it
# from a distribution package or from GitHub
# The same as before applies in regard to shutting down and deallocating the VM in Azure as waagent shutdowns
# only the OS
# -----------------------------------------
# sudo waagent -deprovision+user -force
# -----------------------------------------
