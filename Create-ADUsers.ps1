Import-Module ActiveDirectory

$Users = Import-Csv -Path "C:\users.csv"

foreach ($User in $Users) {
    $Name = "$($User.FirstName) $($User.LastName)"
    $Password = ConvertTo-SecureString $($User.Password) -AsPlainText -Force
    
    New-ADUser -SamAccountName $User.Username `
               -Name $Name `
               -GivenName $User.FirstName `
               -Surname $User.LastName `
               -AccountPassword $Password `
               -Path "OU=LabUsers,DC=grimeslab,DC=local" `
               -Enabled $true `
               -PasswordNeverExpires $true
}
