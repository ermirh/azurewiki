# login to your azure account
Connect-AzAccount

# select the subscription you will work on
$sub = Get-AzSubscription -SubscriptionName 'Azure subscription 1'

# store the definition for billing reader role so we can use this role to create new custom.
$role = Get-AzRoleDefinition "Billing Reader"

# clear the id of the role, give a name, clear descripton what is the purpose of this role and clear scope to where has assigned.
$role.Id = $null
$role.Name = "Billing Accounts Operator"
$role.Description = "Can manage billing account, profiles & invoices"
$role.AssignableScopes.Clear()

# use this cmdlet to get all operations, actions for specific provider
Get-AzProviderOperation "Microsoft.Billing/*" | Format-Table OperationName, Operation, Description

# add action or notActions to the custom role, based on your specific permissions.
$role.Actions.Add("Microsoft.Billing/billingAccounts/billingProfiles/pricesheet/download/action")
$role.Actions.Add("Microsoft.Billing/billingAccounts/billingProfiles/invoices/pricesheet/download/action")
$role.Actions.Add("Microsoft.Billing/billingAccounts/billingProfiles/write")
$role.Actions.Add("Microsoft.Billing/billingAccounts/write")
$role.NotActions.Add("Microsoft.Billing/billingAccounts/billingProfiles/invoiceSections/products/transfer/action")
$role.NotActions.Add("Microsoft.Billing/billingAccounts/billingProfiles/invoiceSections/products/move/action")

$role.AssignableScopes.Add("/subscriptions/$($sub.Id)")

# create the new custom role
New-AzRoleDefinition -Role $role

# verify the new custom role is created successfully. Now you can add role assigment using this role.
Get-AzRoleDefinition | ? {$_.IsCustom -eq $true} | FT Name, Description, IsCustom

#get the object id for a user
$user = (Get-AzADUser -DisplayName 'Az User1').id

#assign the role to a user on the subscription level
New-AzRoleAssignment -ObjectId $user -RoleDefinitionName 'Billing Accounts Operator' -Scope '/subscriptions/$($sub.Id)'
