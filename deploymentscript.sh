appName="finalsptest"

appPassword=$(az ad sp create-for-rbac --name $appName --query password -o tsv)

appId=$(az ad app list --display-name $appName --query "[].appId")
appId=$(echo $appId | tr -d '"[] ' | grep -v '^$')

tenantId=$(az account show --query tenantId -o tsv)

subscriptionId=$(az account show --query id)
subscriptionId=${subscriptionId//\"/}
subscriptionId="/subscriptions/$subscriptionId"

az role assignment create --assignee $appId --role Contributor --scope $subscriptionId

echo $appName
echo $appId
echo $appPassword
echo $tenantId
