#Provide the subscription Id where the VMs reside
$subscriptionId = "<sub_id>"

#Provide the name of the csv file to be exported
$reportName = "AzVMsReport.csv"

Select-AzSubscription $subscriptionId
$report = @()
$vms = Get-AzVM
$nics = Get-AzNetworkInterface | ?{ $_.VirtualMachine -NE $null} 
foreach ($nic in $nics) { 
    $info = "" | Select-Object VmName, ResourceGroupName, Region, VirtualNetwork, Subnet, PrivateIpAddress, OsType
    $vm = $vms | Where-Object -Property Id -eq $nic.VirtualMachine.id  
        $info.OsType = $vm.StorageProfile.OsDisk.OsType 
        $info.VMName = $vm.Name 
        $info.ResourceGroupName = $vm.ResourceGroupName 
        $info.Region = $vm.Location 
        $info.VirtualNetwork = $nic.IpConfigurations.subnet.Id.Split("/")[-3] 
        $info.Subnet = $nic.IpConfigurations.subnet.Id.Split("/")[-1] 
        $info.PrivateIpAddress = $nic.IpConfigurations.PrivateIpAddress 
        $report+=$info 
} 
$report | Format-Table VmName, ResourceGroupName, Region, VirtualNetwork, Subnet, PrivateIpAddress, OsType
$report | Export-CSV "c:/$reportName"