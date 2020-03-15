Import-Module Az.Resources
Connect-AzAccount
Connect-AzureAD

Get-AzSubscription -SubscriptionName 'Azure subscription 1' | Select-AzSubscription

$creds = Get-Credential

$credentials = New-Object Microsoft.Azure.Commands.ActiveDirectory.PSADPasswordCredential `
-Property @{ StartDate=Get-Date; EndDate=Get-Date -Year 2021; Password=$creds.Password};

$sp = New-AzADServicePrincipal -DisplayName 'sp-ansible' -PasswordCredential $credentials

New-AzRoleAssignment -RoleDefinitionName "Contributor" -ObjectId $sp.Id -Scope '/subscriptions/<subscription_id>'