Connect-AzAccount

#select your subscription where going to provision resources
Get-AzSubscription -SubscriptionName '<Subscription_Name>' | Select-AzSubscription

#create a variable for Resource Group (Get-AzResourceGroup)
$resourceGroup = "<Resource_Group_Name>"

#enter username & password for SQL server credentials
$credentials = Get-Credential

#store user & password to pass values into arm template deployment
$sqlUser = $credentials.UserName
$sqlUserPassword = $credentials.Password

#specify local path of the template & parameters file
$templateParam = ".\azure-sql-template\template.parameters.json"
$template = ".\azure-sql-template\template.json"

#test the deployment - empty output is ok, working
Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateParameterFile $templateParam -TemplateFile $template -sqlServerAdministrator $sqlUser -sqlServerAdministratorPwd $sqlUserPassword

#run the ARM deployment
New-AzResourceGroupDeployment -Name "deploy-sql-070320" -ResourceGroupName $resourceGroup -TemplateFile $template -TemplateParameterFile $templateParam -sqlServerAdministrator $sqlUser -sqlServerAdministratorPwd $sqlUserPassword -Force
