#Input parameters for the script
param (
    [string]$FileName,  #Path to the file containing the list of values
    [string]$DataType,  #Type of sorted values requested: "alpha", "numeric", "both"
    [string]$SortOrder  #Sort order: "ascending", "descending"
)

#Validate DataType and SortOrder, returns an error if not a valid type
if ($DataType -notin @("alpha", "numeric", "both")) {
    Write-Error "Invalid DataType value. Valid values are: 'alpha', 'numeric', 'both'."
    exit
}

if ($SortOrder -notin @("ascending", "descending")) {
    Write-Error "Invalid SortOrder value. Valid values are: 'ascending', 'descending'."
    exit
}


#Function to read and split file content, returns an error if the file is not able to be read
function GetFileContent {
    param ([string]$fileName)
    try {
        $fileContent = Get-Content -Path $fileName
        #If the file is empty then exit the script and print an error
        if ($fileContent -eq $null) {
            Write-Error "The file is empty."
            exit
        }
        return $fileContent -split ','
    } catch {
        Write-Error "Error reading file: $_"
        exit
    }

}


#Function to filter numeric values
function GetNumericValues {
    param ([array]$values)
    return $values | Where-Object {
        $_ = $_.Trim()
        ($_ -match "^[0-9eE.-]+$") -and (-not ($_ -match "^'.*'$"))
    }
}


#Function to filter alphanumeric values
function GetAlphaValues {
    param ([array]$values)
    return $values | Where-Object {
        $_ = $_.Trim()
        ($_ -match "^'.*'$") -or ($_ -match "^[A-Za-z]+$")
    }
}


#Function to sort values accoridng to the sortOrder
function SortValues {
    param ([array]$values, [string]$sortOrder)
    if ($sortOrder -eq "ascending") {
        return $values | Sort-Object

    }elseif ($sortOrder -eq "descending") {
        return $values | Sort-Object -Descending
    }
}


#Read and split file content
$values = GetFileContent -fileName $FileName

#Split values into numeric and alphanumeric lists
$numericValues = GetNumericValues -values $values
$alphaValues = GetAlphaValues -values $values

#Convert and sort values based on DataType
if ($DataType -eq "numeric") {
    $values = $numericValues | ForEach-Object { [decimal]$_ }
    $values = SortValues -values $values -sortOrder $SortOrder

} elseif ($DataType -eq "alpha") {
    $values = $alphaValues | ForEach-Object { [string]$_ }
    $values = SortValues -values $values -sortOrder $SortOrder

} elseif ($DataType -eq "both") {
    $numericValues = $numericValues | ForEach-Object { [decimal]$_ }
    $alphaValues = $alphaValues | ForEach-Object { [string]$_ }
    $numericValues = SortValues -values $numericValues -sortOrder $SortOrder
    $alphaValues = SortValues -values $alphaValues -sortOrder $SortOrder
    $values = $numericValues + $alphaValues
}

#Rejoin and output the final list
$output = $values -join ","
Write-Output $output
