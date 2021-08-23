#Create and get my Excel Obj
$x1 = New-Object -comobject Excel.Application
$UserWorkBook = $x1.Workbooks.Open("C:\Users\aalleshouse\Desktop\Excel Docs\Status Report.xlsx")

#Select first Sheet
$UserWorksheet = $UserWorkBook.Worksheets.Item(1)
$UserWorksheet.activate()

#Copy the part of the sheet I want in the Email
$rgeSource=$UserWorksheet.range("A1","E20").Copy()


#create outlook Object
$Outlook = New-Object -comObject  Outlook.Application 
$Mail = $Outlook.CreateItem(0) 
$Mail.Recipients.Add("chris.rosiak@lcs.com")
$Mail.Recipients.Add("AlexandirAlleshouse@gmail.com")
$Mail.Subject = "Status Report - Alexandir Alleshouse" 

#Add the text part I want to display first
#$Mail.Body = "My Comment on the Excel Spreadsheet" 

#Then Copy the Excel using parameters to format it
$Mail.Getinspector.WordEditor.Range().PasteExcelTable($true,$false,$false)
#Then it becomes possible to insert text before
$wdDoc = $Mail.Getinspector.WordEditor
$wdRange = $wdDoc.Range()


$CurrentDay = (Get-Date).ToShortDateString()
$11DaysBack = (Get-Date).AddDays(-11).ToShortDateString() 



$wdRange.InsertBefore("Chris, Below is a status report for me from $11DaysBack to $CurrentDay
")
$Mail.Display()
$Mail.Send()