# Define the project file and configuration
$projectFile = "./Umbraco.Community.IconPack.Iconoir/Umbraco.Community.IconPack.Iconoir.csproj"
$configuration = "Release"
$outputDirectory = "./build.out"

# Delete all files in the output directory
if (Test-Path $outputDirectory) {
    Remove-Item "$outputDirectory/*"
}

# Save the current directory
Push-Location

# Change the current directory to the JS client folder
Set-Location "./Umbraco.Community.IconPack.Iconoir/client"

# Run the Node.js command/s
npm install             ## Usual NPM install - gets the Iconoir package & its SVGs
npm run build:iconpack  ## Runs the custom NPM script (copies the SVGs into a JS file and creates an Icon Dictionary)
npm run build           ## Vite build to create the JS bundle that we will ship

# Get the version from the 'node_modules/iconoir/package.json' as we will use the as the Nuget package version
$packageJson = Get-Content "./node_modules/iconoir/package.json" -Raw | ConvertFrom-Json
$version = $packageJson.version

## Print out the package json
Write-Output "Iconoir NPM Package version: $version"

# Go back to the previous directory
Pop-Location

# Pack the project into a NuGet package
dotnet pack $projectFile --configuration $configuration --output $outputDirectory /p:Version=$version

# Check if the pack was successful
if ($LASTEXITCODE -eq 0) {
    Write-Output "Pack successful."
} else {
    Write-Output "Pack failed."
    exit $LASTEXITCODE
}