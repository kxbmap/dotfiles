@{
    ShowModuleLoadDetails = $false # Display module load details during
                                   # Import-Module.

    CD_GetChildItem = $false       # Display the contents of new provider
                                   # location after using cd (Set-LocationEx).
                                   # Mutually exclusive with
                                   # CD_EchoNewLocation.

    CD_EchoNewLocation = $true     # Display new provider location after using
                                   # cd (Set-LocationEx).
                                   # Mutually exclusive with CD_GetChildItem.

    # TextEditor = 'Notepad.exe'     # Default text editor used by the Edit-File
                                   # function.
    TextEditor = 'C:\Program Files\Sublime Text 2\sublime_text.exe'

    PromptTheme = 'Modern'         # Prompt string and window title updates.
                                   # To enable, first set the ModulesToImport
                                   # setting for Prompt below to $true.
                                   # Then set this value to one of: 'Modern',
                                   # 'WinXP' or 'Jachym'.

    PageHelpUsingLess = $true      # Pscx replaces PowerShell's More function.
                                   # When this setting is set to $true,
                                   # less.exe is used to page items piped to
                                   # the More function. Less.exe is powerful
                                   # paging app that allows advanced
                                   # navigation and search. Press 'h' to
                                   # access help inside less.exe and 'q' to
                                   # exit less.exe. Set this setting to $false
                                   # to use more.com for paging.

    SmtpFrom = $null               # These settings are used by the PSCX
                                   # Send-SmtpMail cmdlet.
    SmtpHost = $null               # Specify a default SMTP server.
    SmtpPort = $null               # Specify a default port number.  If not
                                   # specified port 25 is used.

    FileSizeInUnits = $false       # Pscx can prepend format data for the
                                   # display of file information. If this
                                   # value is set to $true, file sizes are
                                   # displayed in using KB,MG,GB and TB units.
}
