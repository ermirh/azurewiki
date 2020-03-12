# login to Azure account 
Connect-AzAccount

# select the subscription to work in, deploying resources
Get-AzSubscription -SubscriptionName "Azure subscription 1" | Select-AzSubscription

$rg = Get-AzResourceGroup -Name "azwiki8fc06mrg"
$keyvault = Get-AzKeyVault -ResourceGroupName $rg.ResourceGroupName -VaultName "kvwiki83d"
$storageAccount = Get-AzStorageAccount -ResourceGroupName $rg.ResourceGroupName -Name "sac76ksfs"

# KeyVault application Id across all azure platform
$keyVaultAppId = "cfa8b339-82a2-471a-a3c9-0fc0be7a4093"

$storageAccountKey = "key1"

$userPrincipalId = $(Get-AzADUser -SearchString "e3r").Id

$recyclePeriod = [System.Timespan]::FromDays(30)

# Assigning RBAC role "Storage Account Key Operator Service Role" to Key Vault
New-AzRoleAssignment -ApplicationId $keyVaultAppId -RoleDefinitionName "Storage Account Key Operator Service Role" -Scope $storageAccount.Id

Set-AzKeyVaultAccessPolicy -VaultName $keyvault.VaultName -ObjectId $userPrincipalId -PermissionsToStorage get, set

# Giving our user access to all storage account permissions, on the Key Vault instance
Set-AzKeyVaultAccessPolicy -VaultName $keyvault.VaultName -ObjectId $saId -PermissionsToStorage get, list, delete, set, update, regeneratekey, getsas, listsas, deletesas, setsas, recover, backup, restore, purge

# Adding our storage account to your Key Vault's managed storage accounts. Specifying regenerating period key of every 90 days.
Add-AzKeyVaultManagedStorageAccount -VaultName $keyvault.VaultName -AccountName $storageAccount.StorageAccountName -ActiveKeyName $storageAccountKey -RegenerationPeriod $recyclePeriod -AccountResourceId $storageAccount.Id