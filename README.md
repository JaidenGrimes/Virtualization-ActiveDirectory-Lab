# Virtualization & Active Directory Lab

## Overview
Deploys and configures a multi-VM enterprise Windows Server environment in VirtualBox. This lab simulates core Systems Administration and Identity & Access Management (IAM) workflows, including Domain Controller promotion, automated bulk user provisioning via PowerShell, and least-privilege security enforcement through Group Policy Objects (GPOs).

## Environment & Prerequisites
- **Hypervisor:** Oracle VM VirtualBox
- **Domain Controller:** Windows Server 2022 (`DC-01`)
- **Client Endpoint:** Windows 11 (`WIN11-CLI`)
- **Network Architecture:** VirtualBox NAT Network (`10.0.2.0/24`, Static IP: `10.0.2.10`)
- **Domain Name:** `grimeslab.local`

---

## Deployment & Configuration Steps

### 1. VirtualBox Network Setup
Configured an isolated NAT Network (`10.0.2.0/24`) with DHCP enabled to allow secure private inter-VM communication between the Domain Controller and client endpoints without exposing them directly to the host network.

### 2. Active Directory Domain Controller (`DC-01`)
- Deployed Windows Server 2022 Standard Evaluation (Desktop Experience).
- Configured static IPv4 addressing (`10.0.2.10`, Subnet: `255.255.255.0`, Gateway: `10.0.2.1`, DNS: `127.0.0.1`).
- Installed Active Directory Domain Services (AD DS) and DNS Server roles, promoting the server as the root domain controller for `grimeslab.local`.

### 3. AD Structure & PowerShell Automation (`LabUsers` OU)
- Created a dedicated Organizational Unit (`LabUsers`) using Active Directory Users and Computers (`dsa.msc`).
- Wrote and executed a custom PowerShell script (`Create-ADUsers.ps1`) utilizing `Import-Csv` and `New-ADUser` to bulk-provision domain accounts (`jdoe`, `jsmith`, `mwilson`) with secure temporary passwords and unexpiring account policies.

**_Active Directory Users & Provisioned Users_** <img width="1919" height="1011" alt="01_ActiveDirectory_Users_Provisioned" src="https://github.com/user-attachments/assets/f7c0f307-ad7b-4a07-bd91-c3159c5f05c2" />

### 4. Group Policy Management (`GPO-RestrictControlPanel`)
- Authored a custom Group Policy Object (`GPO-RestrictControlPanel`) linked directly to the `LabUsers` OU via the Group Policy Management Console (`gpmc.msc`).
- Configured user configuration administrative templates to disable access to the Control Panel and PC settings for standard domain users.

**_Group Policy Baseline Link_** <img width="1919" height="1009" alt="02_GroupPolicy_GPO_ControlPanel_Restriction" src="https://github.com/user-attachments/assets/4eab9509-80ce-42d4-8f04-821012a46676" />

### 5. Client Domain Join & GPO Enforcement (`WIN11-CLI`)
- Configured client network adapter with static DNS pointing to `10.0.2.10`.
- Joined the Windows 11 virtual machine to `grimeslab.local` using domain administrator credentials.
- Verified GPO enforcement by logging in as domain user `jdoe` and testing Control Panel restrictions.

**_Domain Join & GPO Enforcement_** <img width="1023" height="538" alt="03_Win11_GPO_Restriction_Enforcement" src="https://github.com/user-attachments/assets/c119d4cc-bc93-4bac-8fe4-6f2ccfb7b1fd" />

---

## Key Takeaways
- **Automated IAM:** Streamlined user account creation using PowerShell scripting and CSV bulk processing, reducing manual administrative overhead.
- **Security Hardening:** Implemented least-privilege administrative boundaries and security baselines using Group Policy Objects (GPOs).
- **Enterprise Networking:** Validated core TCP/IP routing, DNS name resolution, and domain authentication across multi-OS virtual machines.
