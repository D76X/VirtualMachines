# https://app.pluralsight.com/course-player?clipId=742dbe9b-3746-45a8-8803-d42f288c6835

$rg = "resource-group"
$vmName = "resource-group"

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

# CS stop a VM without deprovisioning it and do it on a PS job os that 
# the shell doe snot block at the call site
# Notice that the | pipe operator is used
Get-ChildItem "Azure:/${subName}/VirtualMachines/${vmName}" | Stop-AzVM -StayProvisioned -Force -AsJob

# Stop & Deprovision a VM
# If you do not deprovision a VM then it will incur charges!
Get-ChildItem "Azure:/${subName}/VirtualMachines/${vmName}" | Stop-AzVM -StayProvisioned -Force -AsJob