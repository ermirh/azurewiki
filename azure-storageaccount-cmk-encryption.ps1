# login to Azure account 
Connect-AzAccount

# select the subscription to work in, deploying resources
Get-AzSubscription -SubscriptionName "<Subscription_Name>" | Select-AzSubscription

#define variables for the ResourceGroup, Key Vault and Storage Account in your environment 
$rg = Get-AzResourceGroup -Name "<Resource_Group_Name>"
$keyvault = Get-AzKeyVault -ResourceGroupName $rg.ResourceGroupName -VaultName "cmk-vault060320-demo"
$sa = Get-AzStorageAccount -ResourceGroupName $rg.ResourceGroupName -Name "sa73nm02jfxq2"

# we assign a system-assigned managed identity to the storage account, to give permission to Key Vault keys operations 
$saPrincipal = Set-AzStorageAccount -ResourceGroupName $rg.ResourceGroupName -Name $sa.StorageAccountName -AssignIdentity

$saPrincipal.Identity.PrincipalId

# create an access policy for the key vault so that the storage account has permissions to access it, using MSI we created.
Set-AzKeyVaultAccessPolicy -VaultName $keyvault.VaultName -ObjectId $saPrincipal.Identity.PrincipalId -PermissionsToKeys wrapkey,unwrapkey,get,recover

# create a new KEY on the vault, to use for encryption of data-at-rest in SA.
$key = Add-AzKeyVaultKey -VaultName $keyvault.VaultName -Name "storageaccountcmk" -Destination 'Software'

# set Storage account to use customer-managed keys and specify the key we just create to associate with the storage account.
Set-AzStorageAccount -Name $sa.StorageAccountName -ResourceGroupName $rg.ResourceGroupName -KeyvaultEncryption -KeyVaultUri $keyvault.VaultUri -KeyName $key.Name -KeyVersion $key.Version

# verify after the encryption status of your Storage Account
$sa.Encryption