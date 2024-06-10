# PowerShell Script for Sorting Values

This PowerShell script reads the contents of a file with comma-separated values and prints the numeric and/or alphabetic values from the file, sorted in the specified order.

---
## Usage

### Parameters

1. **FileName**: Path to the file containing the list of values.
2. **DataType**: Type of sorted values requested. Valid values:
   - `alpha`
   - `numeric`
   - `both`
3. **SortOrder**: Sort order for the values. Valid values:
   - `ascending`
   - `descending`

### Command to Run in Powershell

```powershell
.\MyApp.ps1 "<FileName>" "<DataType>" "<SortOrder>"
```
### Example
**Numeric Values in Ascending Order**

sample1.txt is a text file containing "1, 4, 6, 7, 3, 2, 1.5"
```powershell
.\MyApp.ps1 "sample1.txt" "numeric" "ascending"
```
**Output**
```powershell
1,1.5,2,3,4,6,7
```
### Features

- **Modular Functions**: Improves readability, reusability, and maintainability.
- **Error Handling**: Validates parameters and handles empty files.
- **DataType and SortOrder Validation**: Ensures only valid values are accepted.

### Functions

1. **GetFileContent**: Reads and splits the file content, exits on error.
2. **GetNumericValues**: Filters and trims numeric values.
3. **GetAlphaValues**: Filters and trims alphanumeric values.
4. **SortValues**: Sorts values based on the specified order.

### Main Logic

- Reads and splits file content.
- Filters values into numeric and alphanumeric lists.
- Converts and sorts values based on `DataType`.
- Joins and outputs the final list.

---
