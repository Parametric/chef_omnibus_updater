<#
.SYNOPSIS
Updates the chef client to a specified or latest version.  Only works on Win2k8R2 and W7.  Requires wget is installed.
.PARAMETER version
The version of the chef client to install.  Be careful to use full major.minor.revision (10.18.2).  If ommitted, installs latest.
.EXAMPLE
.\Update-ChefClient.ps1 10.18.2
#>
$version = $args[0] 

# Create Session to Remote Computer
Write-Host "Uninstalling previous versions of chef, if any.  This will take a while..."
$chefinstalls = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -like 'Opscode Chef Client Installer*'}
foreach($install in $chefinstalls)
{ if($install -ne $null)
  {
    Write-Host "Uninstalling " + $install.Name
    $install.Uninstall()
  }
}

Write-Host "Downloading desired version of Chef-Client"
$url = "http://www.opscode.com/chef/download?v=$version&prerelease=false&p=windows&pv=2008r2&m=x86_64"
$path = Join-Path -Path $env:TEMP -ChildPath "chefinstaller.msi"
if(Test-Path $path){
  Remove-Item -Force -Path $path
}
$client = new-object System.Net.WebClient
$client.DownloadFile("$url", "$path")

#Write-Host "Executing installer"
Start-Process -FilePath "msiexec.exe" -ArgumentList "/qb /i $path"
