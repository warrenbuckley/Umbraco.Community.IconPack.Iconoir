# Define the project file and configuration
$projectFile = "./Umbraco.IconPack.Iconoir/Umbraco.IconPack.Iconoir.csproj"
$configuration = "Release"
$outputDirectory = "./build.out"
$version = "7.7.0" ## This needs to be in sync with the NPM package

# Delete all files in the output directory
if (Test-Path $outputDirectory) {
    Remove-Item "$outputDirectory/*"
}

# Pack the project into a NuGet package
dotnet pack $projectFile --configuration $configuration --output $outputDirectory /p:Version=$version

# Check if the pack was successful
if ($LASTEXITCODE -eq 0) {
    Write-Output "Pack successful."
} else {
    Write-Output "Pack failed."
    exit $LASTEXITCODE
}