# SQL Server Restore Automation

## Overview

This project demonstrates the automation of a Microsoft SQL Server database restoration workflow using Ansible and PowerShell.

The objective is to reduce manual intervention during database restoration operations, improve repeatability, and ensure a consistent recovery process across environments.

---

## Features

- Automated SQL Server database restoration
- Multi-database support
- Automatic backup file analysis
- Dynamic generation of RESTORE DATABASE commands
- Automatic mapping of MDF and LDF files
- Service stop and start orchestration
- Post-restoration validation
- Restoration reporting
- Error handling and logging

---

## Technologies

- Ansible
- PowerShell
- Microsoft SQL Server
- Windows Server

---

## Workflow

```text
Application Services
        │
        ▼
Stop Services
        │
        ▼
Database Restoration
        │
        ▼
Database Configuration
        │
        ▼
Validation Checks
        │
        ▼
Reporting
    
