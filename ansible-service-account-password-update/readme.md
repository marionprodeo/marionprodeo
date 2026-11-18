# Service Account Password Renewal

## Overview

This project demonstrates the automation of service account password rotation across Windows servers using Ansible.

The purpose of this automation is to reduce operational effort, improve consistency and minimize service interruptions caused by service account password changes.

The playbook automatically updates Windows Services and Scheduled Tasks that depend on a given service account.

---

## Context

Service accounts are frequently used by:

- Windows Services
- Scheduled Tasks
- Enterprise Applications

When a password is changed in Active Directory, every dependent component must be updated to prevent authentication failures.

Manual execution can be time-consuming and error-prone, especially when several servers are involved.

This automation standardizes the update process.

---

## Objectives

- Automate service account password rotation
- Reduce manual effort
- Minimize service disruptions
- Ensure configuration consistency
- Improve platform reliability

---

## Technologies

| Technology | Purpose |
|------------|---------|
| Ansible | Automation and orchestration |
| PowerShell | Windows administration |
| Active Directory | Service account management |
| Windows Server | Target platform |

---

## Architecture

```text
Active Directory
        │
        ▼
Password Renewal
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
Configuration Validation
```

---

## Workflow

### 1. Service Account Selection

The target service account is retrieved from configuration variables.

### 2. User Rights Assignment

The playbook ensures that the account has the required Windows privileges:

- Log on as a batch job
- Log on as a service

### 3. Scheduled Task Update

All scheduled tasks configured with the service account are identified and updated with the new credentials.

### 4. Windows Service Update

All Windows services configured with the service account are detected and updated automatically.

### 5. Validation

The environment is checked to ensure that services and scheduled tasks continue to operate correctly after the password update.

---

## Benefits

- Reduced operational workload
- Faster password rotation procedures
- Consistent updates across servers
- Reduced risk of authentication failures
- Improved service availability

---

## Technical Challenges

### Dependency Discovery

The automation identifies all services and scheduled tasks using the target account before applying updates.

### Consistency

Ansible ensures that all servers receive the same configuration changes.

### Security

Password updates are centralized and controlled through automation instead of manual operations.

---

## Skills Demonstrated

### Automation

- Ansible Playbook Development
- Infrastructure Automation
- Configuration Management

### Windows Administration

- Windows Services
- Scheduled Tasks
- Local Security Policies

### Identity Management

- Active Directory
- Service Accounts
- Privilege Management

### Operations

- Incident Prevention
- Change Management
- Platform Reliability

---

## Related Project

This automation was developed as a continuation of the Service Account Monitoring project.

The monitoring solution identifies accounts approaching password expiration and exposes metrics through Grafana and InfluxDB dashboards.

The renewal playbook provides the remediation workflow by automatically updating dependent services and scheduled tasks after password rotation.

---

## Disclaimer

This repository contains a simplified and anonymized implementation inspired by real-world operational requirements.

No confidential information, customer data, infrastructure details or proprietary code from clients or employers are included.
