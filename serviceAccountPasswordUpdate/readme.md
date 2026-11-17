# Automated Service Account Password Renewal

## Overview

This project demonstrates how to automate the update of Windows services and scheduled tasks after a service account password renewal.

The objective is to ensure service continuity while reducing manual operations and configuration errors.

---

## Context

Service accounts are commonly used to run Windows services and scheduled tasks.

When a password is renewed, every dependent service and scheduled task must be updated accordingly. In large environments, this operation can become time-consuming and error-prone.

This Ansible playbook automates the process.

---

## Features

- Update Log on as a batch job permissions (`SeBatchLogonRight`)
- Update Log on as a service permissions (`SeServiceLogonRight`)
- Identify scheduled tasks using the target service account
- Update scheduled task credentials
- Identify Windows services using the target service account
- Update Windows service credentials
- Apply changes across multiple servers

---

## Technologies

- Ansible
- PowerShell
- Windows Server
- Active Directory
- WinRM

---

## Workflow

```text
Password Renewal
        │
        ▼
Active Directory Account
        │
        ▼
Ansible Playbook
        │
        ├── Update User Rights
        │
        ├── Update Scheduled Tasks
        │
        ├── Update Windows Services
        │
        ▼
Validation
```

---

## Playbook Structure

```text
ansible-service-account-renewal/
├── playbooks/
│   └── update-service-account.yml
├── vars/
│   └── main.yml
├── docs/
│   └── architecture.md
└── README.md
```

---

## Benefits

- Reduced operational effort
- Faster account renewal process
- Consistent configuration across servers
- Lower risk of service disruption
- Improved platform reliability

---

## Disclaimer

This repository contains a generic implementation inspired by real operational requirements.

No confidential or proprietary information from clients or employers is included.
