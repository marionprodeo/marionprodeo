# SQL Server Restore Automation

## Overview

This project demonstrates the automation of a SQL Server database restoration workflow using Ansible and PowerShell.

The solution was designed to reduce manual intervention during restoration operations, increase repeatability across environments, and provide automated validation after recovery procedures.

The restoration process includes service orchestration, dynamic SQL restoration, validation checks and reporting.

---

## Context

Database restoration is a common operational task during:

- Platform maintenance
- Environment refreshes
- Recovery operations
- Application migrations
- Testing activities

Manual execution can be time-consuming and introduces a risk of configuration mistakes.

This project automates the restoration process while ensuring consistency and traceability.

---

## Objectives

- Automate database restoration procedures
- Reduce human intervention
- Preserve existing database file locations
- Validate restored databases automatically
- Improve operational reliability
- Generate restoration reports

---

## Technologies

| Technology | Purpose |
|------------|---------|
| Ansible | Workflow orchestration |
| PowerShell | Restoration logic execution |
| SQL Server | Database platform |
| Windows Server | Target environment |

---

## Architecture

```text
                Backup Files
                     │
                     ▼
        ┌────────────────────────┐
        │ Ansible Playbook       │
        └───────────┬────────────┘
                    │
                    ▼
        ┌────────────────────────┐
        │ PowerShell Execution   │
        └───────────┬────────────┘
                    │
                    ▼
        ┌────────────────────────┐
        │ SQL Server Restore     │
        └───────────┬────────────┘
                    │
                    ▼
        ┌────────────────────────┐
        │ Validation & Reporting │
        └────────────────────────┘
```

## Workflow

### 1. Service Orchestration

Application services are stopped before database operations begin in order to avoid active connections and ensure data consistency.

### 2. Backup Analysis

The playbook inspects backup files and extracts:

- Logical file names
- Data files
- Log files

### 3. Database Restoration

The restoration procedure:

- Retrieves existing file locations
- Generates dynamic RESTORE commands
- Applies file remapping automatically
- Forces databases into SINGLE_USER mode
- Performs restoration
- Returns databases to MULTI_USER mode

### 4. Validation

After restoration, validation checks are executed to verify:

- Database accessibility
- Restoration status
- File consistency
- Service readiness

### 5. Reporting

The process generates logs to provide operational visibility and facilitate troubleshooting.


---

## Key Challenges

### Dynamic File Mapping

Database backups may contain logical files that differ from the target environment.

The automation dynamically maps backup logical names to existing physical files before restoration.

### Multi-Database Management

The same workflow can process several databases during a single execution.

### Consistency

Using Ansible guarantees that the restoration process follows the same steps every time.

---

## Benefits

- Faster restoration operations
- Standardized procedures
- Reduced configuration errors
- Improved reliability
- Better traceability
- Easier maintenance

---

## Skills Demonstrated

### Automation

- Ansible Playbook Development
- Infrastructure Automation
- Workflow Orchestration

### Scripting

- PowerShell
- SQL Query Generation
- Error Handling

### Administration

- Microsoft SQL Server
- Windows Server
- Service Management

### Operations

- Recovery Procedures
- Validation Processes
- Operational Reporting

---

## Project Status

Portfolio project based on real-world operational challenges.

Implementation details have been simplified and anonymized to protect client confidentiality while preserving the technical concepts and workflow.

---

## Disclaimer

This repository contains a demonstration implementation intended for educational and portfolio purposes.

No confidential information, customer data, infrastructure details or proprietary code from clients or employers are included.
