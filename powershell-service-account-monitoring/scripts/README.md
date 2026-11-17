# Service Account Monitoring

## Overview

This project contains a PowerShell script that takes an Active Directory domain and an XML configuration file as input parameters. The script queries Active Directory to retrieve the password expiration date of one or more service accounts and returns the number of days remaining before expiration.

The collected data can then be used for monitoring and visualization purposes, for example within a Grafana dashboard.

---

## Script

The `MyModule.psm1` module included in this project was not developed by me and is provided as an external dependency.

### Important Variables

| Variable | Description |
|-----------|-------------|
| `$TodayDate` | Current date used to calculate the number of days remaining before password expiration. |
| `$Limit` | Warning threshold used to identify accounts approaching expiration. |
| `$SA_conf` | XML configuration file containing the service account information to be checked. |

---

## Configuration

Before running the script, the `ServiceAccount.xml` file must be completed with the required information.

### Domain Configuration

| Parameter | Description |
|-----------|-------------|
| `Name` | Active Directory domain name containing the service account. |
| `DC` | Domain Controller used to perform the query. |

### Service Account Configuration

| Parameter | Description |
|-----------|-------------|
| `Name` | Service account name to monitor. |

---

## Example Workflow

```text
ServiceAccount.xml
        │
        ▼
PowerShell Script
        │
        ▼
Active Directory Query
        │
        ▼
Password Expiration Date
        │
        ▼
Days Remaining Calculation
        │
        ▼
Monitoring / Dashboard Visualization
```

---

## Use Case

This solution helps administrators proactively identify service accounts whose passwords are close to expiration, reducing the risk of application or service outages caused by expired credentials.

## Technologies

- PowerShell
- Active Directory
- XML
- Grafana (for dashboard integration)
