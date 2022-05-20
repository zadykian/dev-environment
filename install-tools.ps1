$installRootLocation = "C:\Tools"

$packagesToInstall = @(
	"Google.Chrome",
	"Telegram.TelegramDesktop",
	"Notion.Notion",
	"FinalWire.AIDA64.Extreme",

	"Microsoft.dotnet",
	"DevToys",
	"Microsoft.PowerShell",
	"Git.Git",
	"Docker.DockerDesktop",

	"JetBrains.Rider",
	"JetBrains.DataGrip",

	"Microsoft.VisualStudioCode",
	#"Microsoft.VisualStudio.2022.Community",

	"Microsoft Remote Desktop",
	"mRemoteNG.mRemoteNG",
	"AnyConnect",
	"OpenVPNTechnologies.OpenVPNConnect"
)

$installedPackages = winget list

function PackageIsNotInstalled([string]$packageId) {
	$occurrences = $installedPackages | Where-Object { $_ -match $packageId }
	$occurrences.Count -eq 0
}

$notInstalledPackages = $packagesToInstall | Where-Object { PackageIsNotInstalled $_ }

foreach ($packageId in $notInstalledPackages) {
	$installLocation = Join-Path $installRootLocation $packageId
	winget install $packageId --location $installLocation
}

# Change nuget packages cache location
[System.Environment]::SetEnvironmentVariable("NUGET_PACKAGES", "D:\NugetPackagesCache")