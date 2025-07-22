' Local_Normal_Task

'#Language "WWB-COM"

Option Explicit

Public cstProjectPath As String
Public taskFlagPath As String
Public parentDirPath As String

Public taskFlagName As String
Public taskFlagNameWithoutExtension As String

'X parameters As String
Public str_x_D As String
Public str_x_aa As String
Public str_x_cc As String
Public str_x_mm As String
'End of X parameters As String

'X parameters As Double
Public x_D As Double
Public x_aa As Double
Public x_cc As Double
Public x_mm As Double
'End of X parameters As Double

Sub Main ()
	Dim maxAttempt,count As Long
	Dim status As String
	maxAttempt=999999
	count=0

	cstProjectPath = "%CSTPROJFILE%"
	OpenFile(cstProjectPath)

	Dim startTime,endTime As Double

	status = "NoTask"

	taskFlagPath = "%TASKFLAGFILE%"

	parentDirPath = AddSlashToPath(GetParentDirectory(taskFlagPath))

    taskFlagName = GetFileName(taskFlagPath)

    taskFlagNameWithoutExtension = RemoveFileExtension(taskFlagName)

	Do While count < maxAttempt
		If IsFileExists(taskFlagPath) Then
			Debug.Print "CST Local Task Running"
			count = 0
			status = "Normal"
			Exit Do
		Else
			count += 1
		End If

		Wait 1
	Loop

	If status = "Normal" Then
		Debug.Print "Local Normal Task"
		Open (taskFlagPath) For Input As #1
		'user can modify the read of X parameters
		Line Input #1, str_x_D
		Line Input #1, str_x_aa
		Line Input #1, str_x_cc
		Line Input #1, str_x_mm
		Close #1

		x_D = CDbl(str_x_D)
		x_aa = CDbl(str_x_aa)
		x_cc = CDbl(str_x_cc)
		x_mm = CDbl(str_x_mm)

		'Change the values of parameters
		StoreDoubleParameter("D",x_D)
		StoreDoubleParameter("aa",x_aa)
		StoreDoubleParameter("cc",x_cc)
		StoreDoubleParameter("mm",x_mm)

		Rebuild

		EigenmodeSolver.Start

		postProcess()
	End If

End Sub
'user functions
Function postProcess()
	Debug.Print "post process"
	Dim i As Integer
	Dim resultDir As String

	resultDir = parentDirPath & taskFlagNameWithoutExtension

	CreateDirectory(resultDir)
'user can modify the following code to decide
'which result to be exported
	For i = 1 to 1
		SelectTreeItem("Tables\0D Results\Frequency (Mode 1)")
		With ASCIIExport
			.Reset
			.FileName (resultDir & "\" & "Mode"& i &"Frequency.txt")
			.Execute
		End With
		SelectTreeItem("Tables\0D Results\Shunt Impedance (Pertubation) beta=1 (Mode 1)")
		With ASCIIExport
			.Reset
			.FileName (resultDir & "\" & "Mode"& i &"ShuntImpedance.txt")
			.Execute
		End With
		SelectTreeItem("Tables\1D Results\R over Q beta=1 (Multiple Modes)")
		With ASCIIExport
			.Reset
			.FileName (resultDir & "\" & "Mode"& i &"RoverQ.txt")
			.Execute
		End With
		SelectTreeItem("Tables\1D Results\Q-Factor (Perturbation) (Multiple Modes)")
		With ASCIIExport
			.Reset
			.FileName (resultDir & "\" & "Mode"& i &"QFactor.txt")
			.Execute
		End With
		
	Next i
End Function
'utility library functions
Function IsFileExists(ByVal strFileName As String) As Boolean
    If Dir(strFileName, 16) <> Empty Then
        IsFileExists = True
    Else
        IsFileExists = False
    End If
End Function

Function CreateDirectory(ByVal directoryPath As String)
    If Dir(directoryPath, vbDirectory) = "" Then
        MkDir directoryPath
    End If
End Function

Function GetParentDirectory(filePath As String) As String
    Dim lastSeparatorIndex As Integer
    Dim parentDirPath As String

    lastSeparatorIndex = InStrRev(filePath, "\")

    If lastSeparatorIndex > 0 Then
        parentDirPath = Left(filePath, lastSeparatorIndex - 1)
    Else
        parentDirPath = ""
    End If

    GetParentDirectory = parentDirPath
End Function

Function GetFileName(filePath As String) As String
    Dim lastSeparatorIndex As Integer

    lastSeparatorIndex = InStrRev(filePath, "\")

    If lastSeparatorIndex > 0 Then
        GetFileName = Mid(filePath, lastSeparatorIndex + 1)
    Else
        GetFileName = filePath
    End If
End Function

Function RemoveFileExtension(fileName As String) As String
    Dim lastDotIndex As Integer

    lastDotIndex = InStrRev(fileName, ".")

    If lastDotIndex > 0 Then
        RemoveFileExtension = Left(fileName, lastDotIndex - 1)
    Else
        RemoveFileExtension = fileName
    End If
End Function

Function AddSlashToPath(path As String) As String
    If Right(path, 1) <> "\" Then
        AddSlashToPath = path & "\"
    Else
        AddSlashToPath = path
    End If
End Function