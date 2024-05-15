# Define the project file and configuration
$projectFile = "./Umbraco.IconPack.Iconoir/Umbraco.IconPack.Iconoir.csproj"
$configuration = "Release"
$outputDirectory = "./build.out"
$version = "7.7.0" ## This needs to be in sync with the NPM package

# Delete all files in the output directory
if (Test-Path $outputDirectory) {
    Remove-Item "$outputDirectory/*"
}

# Save the current directory
Push-Location

# Change the current directory to the JS client folder
Set-Location "./Umbraco.IconPack.Iconoir/client"

# Run the Node.js command/s
npm install             ## Usual NPM install - gets the Iconoir package & its SVGs
npm run build:iconpack  ## Runs the custom NPM script (copies the SVGs into a JS file and creates an Icon Dictionary)
npm run build           ## Vite build to create the JS bundle that we will ship

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