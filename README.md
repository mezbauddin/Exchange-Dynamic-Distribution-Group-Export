Exchange Dynamic Distribution Group Members Export Script
Overview
This PowerShell script enables Microsoft 365 administrators to easily retrieve and export members of a Dynamic Distribution Group (DDG) from Exchange Online to a CSV file. The script is ideal for Exchange and Microsoft 365 administrators who want a simple way to generate a list of users based on the membership rules of a dynamic distribution group.

Features
Dynamic CSV Naming: The CSV file is named dynamically based on the email address of the distribution group, ensuring that it is easy to identify.
Exports Display Name and Email Address: The script retrieves and exports key information about group members—Display Name and Primary Email Address (SMTP).
Handles Recipient Filters: Simulates and retrieves group members based on the recipient filter used by the dynamic distribution group.
Prerequisites
PowerShell: Ensure you are running PowerShell version 5.1 or later.
Exchange Online Management Module: The script will automatically check for the module and install it if needed.
Installation
Clone this repository:

bash
Copy code
git clone https://github.com/mezbauddin/Exchange-Dynamic-Distribution-Group-Export.git
Navigate to the directory:

bash
Copy code
cd Exchange-Dynamic-Distribution-Group-Export
Run the script: You can run the script from PowerShell by passing the required parameters.

Usage
Parameters
UserPrincipalName: The UPN (email address) of an administrator account with permission to access Exchange Online.
GroupIdentity: The email address or identity of the dynamic distribution group to retrieve.
Example Command
powershell
Copy code
.\Export-DDGMembers.ps1 -UserPrincipalName admin@domain.com -GroupIdentity "onelsc.all.staff@elht.nhs.uk"
This will:

Connect to Exchange Online.
Retrieve the dynamic distribution group onelsc.all.staff@elht.nhs.uk.
Export the list of members (Display Name and Email Address) to a dynamically named CSV file at the root of the C: drive.
The file will be named something like:
C:\DynamicDistributionGroupMembers_onelsc_all_staff_at_elht_dot_nhs_dot_uk.csv

Output
CSV File: A CSV file containing two columns:
DisplayName: The full name of the group member.
PrimarySmtpAddress: The email address of the group member.
Sample CSV Output
DisplayName	PrimarySmtpAddress
John Doe	john.doe@elht.nhs.uk
Jane Smith	jane.smith@elht.nhs.uk
...	...
Dependencies
This script relies on the Exchange Online Management module. If it’s not installed, the script will install it for you automatically.

To install manually, you can run:

powershell
Copy code
Install-Module -Name ExchangeOnlineManagement
License
This project is licensed under the MIT License - see the LICENSE file for details.

Contributing
Contributions are welcome! If you have suggestions, bug reports, or enhancements, please open an issue or submit a pull request.

Author
Mezba Uddin

mezbauddin.com
LinkedIn: Mezba Uddin
