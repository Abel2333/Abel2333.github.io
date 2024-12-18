---
layout: single
title:  "NPOI in CSharp"
date:   2024-12-16 09:14 +0800
categories: code CSharp
---

## What is NPOI?

**NPOI** is a C# library which use to read and write the
Microsoft Office format without installing it.
And more significantly, it processes the Microsoft Office
format automatically.

## Excel

For *Excel 97 ~ 2003*, NPOI provide `NPOI.HSSF.UserModel` while
`NPOI.XSSF.UserModel` used to process *Excel 2007+*.
To unify the two versions of the file, `NPOI.SS.UserModel` give
us a interface for both xls and xlsx.

### Read

First of all, `IWorkbook workbook` is needed. This is the
generic interface above-mentioned. And the `FileStream` is also
necessary.

Then you should build a workbook object with
`workbook = new XSSFWorkbook(fs);` or
`workbook = new HSSFWorkbook(fs);` depends on the actual
suffix of excel file. Using this workbook, we could specify
the sheet to read by `ISheet sheet = workbook.GetSheetAT(0)`
(0 is the serial number).

Recall that the first row of sheet is always the Header.
Thus, `IRow header = sheet.GetRow(sheet.FirstRowNum);` might
help to get more information.
For example, use `header.GetCell(i)` to get the `ith` cell in header
and store to `obj`, and `dt.Columns.Add(new DataColumn(obj.ToString()))`
could set column of DataTable.

At last, we could get data rows by `sheet.GetRow(i)`, and process
the datatable or other data structure in CSharp.

### Write

Similar to the reading, first step is to create an `IWorkbook` with
`new XSSFWorkbook()` or `new HSSFWorkbook()`. After that, create a sheet
to store the content: `workbook.CreateSheet(sheetName)`. In the same way, we have
`sheet.CreateRow(i)` and `row.CreateCell(i)`.

Use these methods, it easy to create a whole Workbook filling with data. However,
this workbook cannot write to the file directly for the excel file is a byte file
instead of a text file. We need write it to a `MemoryStream` within `workbook.Write(stream)`
first, and then convert it to bytes data, `var buf = stream.ToArray();`,
writing byte buffer to `FileStream`:

```CS
fs.Write(buf, 0, buf.Length);
fs.Flush();
```

### Value Type

It is easy to notice that C# has different data type to store data. When read
from excel, NPOI could not set the data type automatically. We need to
implement by ourself:

```CS
private static object? GetCellValue(ICell cell)
{
    if (cell == null)
        return null;

    switch (cell.CellType)
    {
        case CellType.Blank:
            return null;
        case CellType.Boolean:
            return cell.BooleanCellValue;
        case CellType.Numeric:
            return cell.NumericCellValue;
        case CellType.String:
            return cell.StringCellValue;
        case CellType.Error:
            return cell.ErrorCellValue;
        case CellType.Formula:
        default:
            return "=" + cell.CellFormula;
    }
}
```

Also, some preprocessing, such as ignoring the whitespace in
strings, could be done here.

And, for the same reason, we should have a `SetCellValue` method:

```CS
private static void SetCellValue(ICell cell, object obj)
{
    switch (obj)
    {
        case int intValue:
            cell.SetCellValue(intValue.ToString());
            break;
        case double doubleValue:
            cell.SetCellValue(doubleValue);
            break;
        case IRichTextString richTextValue:
            cell.SetCellValue(richTextValue);
            break;
        case string stringValue:
            cell.SetCellValue(stringValue);
            break;
        case DateTime dateValue:
            cell.SetCellValue(dateValue);
            break;
        case bool boolValue:
            cell.SetCellValue(boolValue);
            break;
        default:
            cell.SetCellValue(obj.ToString());
            break;
    }
}
```

`cell.SetCellValue(intValue.ToString())` is used to avoid omitting
in case the value is too big.

### Merged Cell

Sometimes, in Excel files, people would merge adjacent cells if
they have the same value. If we do not specify the value, it would be
null except for the first row, first column.

Thus, for each cell, we should figure out wether it is in a merged cell or not.
If it is, set the value equal to the first row, the first column in that
merged cell.

```CS
private static object? GetMergedCellValue(ISheet sheet, int rowIndex, int colIndex)
{
    foreach (CellRangeAddress range in sheet.MergedRegions)
    {
        if (range.IsInRange(rowIndex, colIndex))
        {
            IRow firstRow = sheet.GetRow(range.FirstRow);
            ICell firstCell = firstRow.GetCell(range.FirstColumn);
            return GetCellValue(firstCell)!;
        }
    }
    IRow row = sheet.GetRow(rowIndex);
    return GetCellValue(row.GetCell(colIndex));
}
```
