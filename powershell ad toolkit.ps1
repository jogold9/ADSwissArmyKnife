# Powershell ISE Toolkit for Active Directory

# This is a group of some commonly used Powershell tasks for Microsoft Active Directory.    

# Run a task in the Powershell ISE by highlighting the lines you want to run, and then clicking "Run Selection" button.

#*********************************************

# Add user department & job title
$user = Read-Host "Enter the user name"
$department = Read-Host "Enter the department name"
$title = Read-Host "Enter job title"
Set-ADUser $user -Department $department -Title $title

# Add user to group(s)
$user = Read-Host "Enter the user name"
$continue = "yes" 

Do {
$group = Read-Host "Enter the group name you want to add the user to"
    Add-ADGroupMember -Identity $group -Members $user
$continue = Read-Host "Do you want to add user to another group?"
} While ($continue -ceq "yes")


# Add user custom attribute (use -replace or -remove instead of -add to replace or remove if needed)
$user = Read-Host "Enter the user name you are adding custom attribute for"
$attribute = Read-Host "Enter the custom attribute name"
$value = Read-Host "Enter the value for the custom attribute"
Set-ADUser -identity $user -add @{$attribute = $value}

# Hide user from global address book / Unhide user from global address book
$user = Read-Host "Enter the user name your are hiding or unhiding from address book"
$hide = Read-Host "Enter 'hide' to hide user, or 'unhide' to unhide user"

If ($hide -ceq "hide") {
    Set-Mailbox -Identity $user -HiddenFromAddressListsEnabled $true
} ElseIf ($hide -ceq "unhide") {
    Set-Mailbox -Identity $user -HiddenFromAddressListsEnabled $false
}
Else {
    Write-Host "Cannot understand your response.  Perhaps there was a typo."
}

# Reset user's password
 $user = Read-Host "Enter the user name for subsequent password reset"
 $password = Read-Host "Enter the new password" -AsSecureString
 Set-ADAccountPassword $user -NewPassword $password -Reset

# See Inactive Computer Accounts in gridview
$days = Read-Host "Enter number of days for inactivity cut off"
Search-ADAccount -ComputersOnly -AccountInactive -TimeSpan $days | ogv 

# See Inactive User Accounts in gridview
$days = Read-Host "Enter number of days for inactivity cut off"
Search-ADAccount -UsersOnly -AccountInactive -TimeSpan $days | ogv 


# See Locked Accounts (will return nothing in on locked accounts) / Unlock Account 
Search-ADAccount –LockedOut

$user = Read-Host "Enter the user name to unlock"
Unlock-ADAccount -Identity $user

