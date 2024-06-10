#Input parameters for the script
param (
    [string]$FileName,
    [string]$DataType,
    [string]$SortOrder
)

#Read the contents of the file
$fileContent = Get-Content -Path $FileName

#Split the file contents by commas and store them in an array
$values = $fileContent -split ','

#Split the values into a numeric list
$numericValues = $values | Where-Object { 
    #Trim any leading or trailing whitespace then ensure the value is numeric
    $_ = $_.Trim()
    ($_ -match "^[0-9eE.-]+$") -and (-not ($_ -match "^'.*'$"))
}


#Split the values into an alphanumeric list
$alphaValues = $values | Where-Object { 
    #Trim any leading or trailing whitespace then ensure the value is alphanumeric
    $_ = $_.Trim()
    ($_ -match "^'.*'$") -or ($_ -match "^[A-Za-z]+$")
}


#If the DataType is numeric then convert each value to a decimal
if ($DataType -eq "numeric"){
    $values = $numericValues | ForEach-Object {[decimal]$_}

#If the DataType is alphanumeric then convert each value to a string
}elseif ($DataType -eq "alpha"){
    $values = $alphaValues | ForEach-Object {[string]$_}

#If the DataType is both then convert both lists accordingly
}elseif ($DataType -eq "both") {
    $numericValues = $numericValues | ForEach-Object { [decimal]$_ }
    $alphaValues = $alphaValues | ForEach-Object { [string]$_ }
}



#If the DataType is both, sort both lists
if ($DataType -eq "both") {
    $numericValues = $numericValues | ForEach-Object { [decimal]$_ }
    $alphaValues = $alphaValues | ForEach-Object { [string]$_ }

    # Sort both lists
    if ($SortOrder -eq "ascending") {
        $numericValues = $numericValues | Sort-Object
        $alphaValues = $alphaValues | Sort-Object

    } elseif ($SortOrder -eq "descending") {
        $numericValues = $numericValues | Sort-Object -Descending
        $alphaValues = $alphaValues | Sort-Object -Descending
    }

    #Concatenate the two lists
    $values = $numericValues + $alphaValues

#If the DataType is not both then sort the list accordingly
}else{
    #Sort the values in ascending order
    if ($SortOrder -eq "ascending") {
        $values = $values | Sort-Object

    #Sort the values in descending order
    }elseif ($SortOrder -eq "descending") {
        $values = $values | Sort-Object -Descending
    }
}


#Rejoin the sorted values into a comma-separated list and output the final list
$output = $values -join ","
Write-Output $output