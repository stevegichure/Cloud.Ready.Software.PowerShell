. (Join-Path $PSScriptRoot '.\_Settings.ps1')

$artifactUrl = Get-BCArtifactUrl `
    -country be `
    -sasToken $SecretSettings.InsiderSASToken `
    -select Latest `
    -storageAccount bcinsider

$ContainerName = 'bcdaily'
# $ImageName = $ContainerName

$includeTestToolkit = $false
$includeTestLibrariesOnly = $false

$StartMs = Get-date

New-BcContainer `
    -accept_eula `
    -containerName $ContainerName  `
    -artifactUrl $artifactUrl `
    -Credential $ContainerCredential `
    -auth "UserPassword" `
    -updateHosts `
    -alwaysPull `
    -includeTestToolkit:$includeTestToolkit `
    -includeTestLibrariesOnly:$includeTestLibrariesOnly `
    -licenseFile $SecretSettings.containerLicenseFile `
    -multitenant:$false `
    -isolation hyperv
    # -imageName $imageName `

# Add-FontsToBcContainer -containerName $ContainerName
# Restart-BcContainer -containerName $ContainerName

$EndMs = Get-date
Write-host "This script took $(($EndMs - $StartMs).Seconds) seconds to run"
