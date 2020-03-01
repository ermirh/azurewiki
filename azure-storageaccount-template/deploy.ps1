Connect-AzAccount

Get-AzSubscription -SubscriptionName '<sub_name>' | Select-AzSubscription

#create new resource group - or use already an existing one (Get-AzResourceGroup)#
$resourceGroup = "azurewiki-rg-001"
$templateParamUri = ""
$templateUri = "" 

#create an ARM deployment#
New-AzResourceGroupDeployment -Name "deploy-storageaccount-010320" -ResourceGroupName $resourceGroup