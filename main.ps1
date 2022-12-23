# Import the Active Directory module
Import-Module ActiveDirectory

# Set the base name for the fake users
$baseName = "FakeUser"

# Set the base password for the fake users
$password = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force

# Set the base email address for the fake users
$email = "fakeuser@example.com"

# Set the base path for the fake users' home directories
$homeDirectory = "\\server\homes\fakeuser"

# Set the base path for the fake users' profiles
$profilePath = "\\server\profiles\fakeuser"

# Set the number of fake users to create
$numUsers = 10

# Set the organizational unit (OU) to create the fake users in
$ou = "OU=FakeUsers,DC=example,DC=com"

# Set the user principal name (UPN) suffix
$upnSuffix = "example.com"

# Create the fake users
for ($i = 1; $i -le $numUsers; $i++) {
    # Create a new AD user with the specified name, SAM account name, given name, surname, email address, home directory, profile path, password, and enabled status
    New-ADUser -Name "$baseName$i" -SamAccountName "$baseName$i" -GivenName "$baseName$i" -Surname "$baseName$i" -UserPrincipalName "$baseName$i@$upnSuffix" -EmailAddress "$email$i" -HomeDirectory "$homeDirectory$i" -ProfilePath "$profilePath$i" -AccountPassword $password -Enabled $true

    # Set the path for the new AD user to the specified OU
    Set-ADUser -Identity "$baseName$i" -Path $ou
}
