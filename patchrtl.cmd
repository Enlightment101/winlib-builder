@echo off
 
powershell -Command "Get-ChildItem -Recurse -Filter '*.vcxproj' | ForEach-Object {
    $filePath = $_.FullName
    Write-Host 'Processing' $filePath
    (Get-Content $filePath) -replace 'MultiThreadedDebugDLL', 'MultiThreadedDebug' `
                               -replace 'MultiThreadedDLL', 'MultiThreaded' `
                               | Set-Content $filePath
}"
 
powershell -Command "Get-ChildItem -Recurse -Filter '*.vc' | ForEach-Object {
    $filePath = $_.FullName
    Write-Host 'Processing' $filePath
    (Get-Content $filePath) -replace '/MDd', '/MTd' `
                               -replace '/MD', '/MT' `
                               -replace '-MDd', '-MTd' `
                               -replace '-MD', '-MT' `
                               | Set-Content $filePath
}"
