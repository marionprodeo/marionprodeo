# Service Account Monitoring

## Overview

This project automates the monitoring of Active Directory service account password expiration.

The script queries Active Directory, calculates the number of days remaining before account expiration, and exports the collected information to InfluxDB for dashboard visualization and alerting purposes.

The objective is to proactively identify expiring service accounts and reduce the risk of outages caused by expired credentials.

---

## Context

Service accounts are commonly used by:

- Windows Services
- Scheduled Tasks
- Enterprise Applications
- Database Connections

An expired password may result in application failures, service interruptions, or operational incidents.

This solution provides centralized monitoring and visibility of account expiration dates.

---

## Features

- Active Directory integration
- Multi-domain support
- XML configuration
- Password expiration calculation
- InfluxDB metrics publication
- Grafana dashboard integration
- Automated logging
- Configurable warning threshold
- Detection of non-existent accounts
- Detection of non-expiring accounts

---

## Technologies

| Technology | Purpose |
|------------|---------|
| PowerShell | Automation |
| Active Directory | Account information retrieval |
| InfluxDB | Metrics storage |
| Grafana | Dashboard visualization |
| XML | Configuration management |

---

## Architecture

```text
ServiceAccount.xml
        │
        ▼
PowerShell Script
        │
        ▼
Active Directory
        │
        ▼
Password Expiration Calculation
        │
        ▼
InfluxDB
        │
        ▼
Grafana Dashboard
```

---

## Workflow

### 1. Configuration Loading

The script loads:

- Target domain
- Domain controller
- Service account list

from an XML configuration file.

### 2. Active Directory Query

For each configured service account:

- Verify account existence
- Check password expiration policy
- Retrieve expiration date

### 3. Expiration Analysis

The script calculates:

```text
Expiration Date - Current Date
```

to determine the number of days remaining before password expiration.

### 4. Monitoring Data Export

The following information is published to InfluxDB:

- Service Account Name
- Domain
- Expiration Date
- Remaining Days

### 5. Dashboard Visualization

Grafana dashboards provide visibility of:

- Upcoming expirations
- Critical accounts
- Non-expiring accounts
- Domain-level reporting

---

## Example Output

```text
svc_application expires in 12 days
svc_database expires in 48 days
svc_backup never expires
```

---

## Alert Management

A configurable threshold defines when an account should be considered at risk.

```powershell
$limit = 30
```

Example:

| Days Remaining | Status |
|----------------|---------|
| > 30 | Healthy |
| <= 30 | Warning |
| <= 7 | Critical |

---

## Benefits

- Improved operational visibility
- Reduced risk of service interruption
- Proactive password management
- Centralized monitoring
- Automated reporting
- Simplified operational follow-up

---

## Skills Demonstrated

### Automation

- PowerShell Scripting
- Configuration Management
- Logging

### Directory Services

- Active Directory
- LDAP Queries
- Service Account Management

### Observability

- Metrics Collection
- InfluxDB Integration
- Grafana Dashboards

### Operations

- Monitoring
- Incident Prevention
- Infrastructure Reliability

---

## Future Improvements

Potential enhancements:

- Email notifications
- Microsoft Teams alerts
- Automatic ticket generation
- Password renewal automation through Ansible
- Historical trend reporting

---

## Disclaimer

This project is a simplified and anonymized implementation inspired by real-world operational requirements.

No confidential information, customer data or proprietary code from clients or employers are included.

---

## Related Project

This monitoring solution was later extended with an Ansible automation workflow capable of:

- Renewing service account passwords
- Updating Windows Services
- Updating Scheduled Tasks
- Reducing manual intervention during password rotations

See: ansible-password-update
