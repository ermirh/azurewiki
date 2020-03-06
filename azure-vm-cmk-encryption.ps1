# login to Azure account 
Connect-AzAccount

# select the subscription to work in, deploying resources
Get-AzSubscription -SubscriptionName "Azure subscription 1" | Select-AzSubscription

#define variables for the ResourceGroup, Key Vault and Storage Account in your environment 
$rg = Get-AzResourceGroup -Name "cmk-demo-rg001"
$vm = Get-AzVM -Name "win-cmk-demo01" -ResourceGroupName $rg.ResourceGroupName
$keyvault = Get-AzKeyVault -VaultName "cmk-vault060320-demo" -ResourceGroupName $rg.ResourceGroupName

#see the current status of disks encryption for the VM
Get-AzVMDiskEncryptionStatus -VMName $vm.Name -ResourceGroupName $rg.ResourceGroupName

# create a new key for the encryption of OS/Data disks
$cmkey = Add-AzKeyVaultKey -VaultName $keyvault.VaultName -Name "windows-vm-cmk" -Destination 'Software'

#define all parameters for the encryption command - in a hash table

$VMdiskEncryption = @{
    VMName = $vm.Name
    ResourceGroupName = $rg.ResourceGroupName
    DiskEncryptionKeyVaultUrl = $keyvault.VaultUri
    DiskEncryptionKeyVaultId = $keyvault.ResourceId
    KeyEncryptionKeyUrl = $cmkey.Key.Kid
    KeyEncryptionKeyVaultId = $keyvault.VaultUri
    VolumeType = "All"
}

# change the encryption setting of VM, using all parameters defined above
Set-AzVMDiskEncryptionExtension @VMdiskEncryption

#check again encryption status of the VM disks - after encryption
Get-AzVMDiskEncryptionStatus -VMName $vm.Name -ResourceGroupName $rg.ResourceGroupName