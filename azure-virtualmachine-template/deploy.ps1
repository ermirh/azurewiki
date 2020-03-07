Connect-AzAccount

#select your subscription where going to provision resources
Get-AzSubscription -SubscriptionName '<Subscription_Name>' | Select-AzSubscription

#create a variable for Resource Group (Get-AzResourceGroup)
$resourceGroup = "<Resource_Group_Name>"

#enter username & password for VM credentials
$credentials = Get-Credential

#store user & password to pass values into arm template deployment
$adminUser = $credentials.UserName
$adminPassword = $credentials.Password

#specify local path of the template & parameters file
$templateParam = ".\azure-virtualmachine-template\template.parameters.json"
$template = ".\azure-virtualmachine-template\template.json"

#test the deployment - empty output is ok, working
Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateParameterFile $templateParam -TemplateFile $template -adminUsername $adminUser -adminPassword $adminPassword

#create an ARM deployment
New-AzResourceGroupDeployment -Name "deploy-vm-030320" -ResourceGroupName $resourceGroup -TemplateFile $template -TemplateParameterFile $templateParam -adminUsername $adminUser -adminPassword $adminPassword -Force
