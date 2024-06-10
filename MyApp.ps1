#Input parameters for the script
param (
    [string]$FileName,
    [string]$DataType,
    [string]$SortOrder
)

#Read the content of the file
$fileContent = Get-Content -Path $FileName

#Split the file contents by commas and store them in an array so we can parse each value
$values = $fileContent -split ','

#If the DataType is numeric then convert each value to an int
if ($DataType -eq "numeric"){
    $values = $numbers | ForEach-Object {[float]$_}
}

#Sort the values either ascending or descending based on the value specified by SortOrder
if ($SortOrder -eq "ascending") {
    $values = $values | Sort-Object
} elseif ($SortOrder -eq "descending") {
    $values = $values | Sort-Object -Descending
}

#Rejoin the sorted values into a comma-separated list
$output = $values -join ","

#Output our final list of sorted values
Write-Output $output