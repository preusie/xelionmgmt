foreach ($file in Get-ChildItem -Path "$PSScriptRoot/internal/functions" -Filter *.ps1 -Recurse) {
    Import-Module -Name $file.FullName -ErrorAction Stop
}

foreach ($file in Get-ChildItem -Path "$PSScriptRoot/functions" -Filter *.ps1 -Recurse) {
    Import-Module -Name $file.FullName -ErrorAction Stop
}

foreach ($file in Get-ChildItem -Path "$PSScriptRoot/internal/scripts" -Filter *.ps1 -Recurse) {
    Import-Module -Name $file.FullName -ErrorAction Stop
}

Export-ModuleMember -Function *-Xelion*