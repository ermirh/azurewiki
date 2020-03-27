Connect-AzAccount

Connect-AzureAD
$aad = Get-AzureADTenantDetail

Get-AzureADUser -Top 10

$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "jdEu7l95ve3vH"
$PasswordProfile.ForceChangePasswordNextLogin = $true
$PasswordProfile.EnforceChangePasswordPolicy = $true

# create new AD User
$userProperties = @{
  DisplayName = "AD Test User 1"
  AccountEnabled = $true
  UserPrincipalName = "testuser1@$($aad.VerifiedDomains.Name)"
  MailNickName = "ADTestUser1"
  PasswordProfile = $PasswordProfile
  Country = "United States"
}

New-AzureADUser @userProperties

#create new AD security assigned Group
$groupProperties = @{
  DisplayName = "AD Test Group 1"
  SecurityEnabled = $true
  MailEnabled = $false
  MailNickName = "testgroup1"
}

New-AzureADGroup @groupProperties

$user = Get-AzureADUser -Filter "displayName eq 'AD Test User 1'"

$group = Get-AzureADGroup -Filter "DisplayName eq 'AD Test Group 1'"

# add user as member of a group
Add-AzureADGroupMember -ObjectId $group.ObjectId -RefObjectId $user.ObjectId

Get-AzureADGroupMember -ObjectId $group.ObjectId
