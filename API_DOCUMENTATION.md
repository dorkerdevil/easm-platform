# EASM API Documentation

This document provides detailed information about the API endpoints, request structures, and usage for the External Attack Surface Management (EASM) platform.

## Authentication Endpoints

### Register a new user
- **URL:** `/api/auth/signup`
- **Method:** POST
- **Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password123",
  "full_name": "User Name"
}
```
- **Response:** User creation confirmation or error.

### Obtain JWT token (Login)
- **URL:** `/api/auth/signin`
- **Method:** POST
- **Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```
- **Response:** JWT token for authentication.

### Get authenticated user's profile
- **URL:** `/api/auth/profile`
- **Method:** GET
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Response:** User profile data.

### Update profile fields
- **URL:** `/api/auth/profile`
- **Method:** PUT
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Request Body:** Fields to update (e.g., full_name)
- **Response:** Updated profile data.

### List all users (admin only)
- **URL:** `/api/auth/users`
- **Method:** GET
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Response:** List of users.

### Change a user's role (admin only)
- **URL:** `/api/auth/users/<id>/role`
- **Method:** PUT
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Request Body:**
```json
{
  "role": "admin"
}
```
- **Response:** Role update confirmation.

## Scanning Endpoints

### Start a new scan
- **URL:** `/api/scan/start`
- **Method:** POST
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Request Body:**
```json
{
  "scan_type": "full",
  "targets": ["example.com", "192.168.1.1"],
  "run_nuclei": true,
  "custom_ports": "80,443",
  "options": {}
}
```
- **Response:** Scan job ID and status.

### List scans for the authenticated user
- **URL:** `/api/scan/list`
- **Method:** GET
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Response:** List of scans.

### Get a single scan's status
- **URL:** `/api/scan/<scan_id>`
- **Method:** GET
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Response:** Scan status and details.

### Stop a running scan
- **URL:** `/api/scan/<scan_id>/stop`
- **Method:** POST
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Response:** Stop confirmation.

### List available scan types
- **URL:** `/api/scan/types`
- **Method:** GET
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Response:** List of scan types.

## Results Endpoints

### Get raw results for a scan
- **URL:** `/api/scan/<scan_id>/results`
- **Method:** GET
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Response:** Raw scan results.

### Get a summary of findings
- **URL:** `/api/scan/<scan_id>/summary`
- **Method:** GET
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Response:** Summary data.

### List vulnerabilities from nuclei
- **URL:** `/api/scan/<scan_id>/vulnerabilities`
- **Method:** GET
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Response:** Vulnerabilities list.

### Export scan data
- **URL:** `/api/scan/<scan_id>/export?format=csv`
- **Method:** GET
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Response:** CSV export of scan data.

## Threat Intelligence Endpoints

### Fetch CVE info, related threat actors, and exploit references
- **URL:** `/api/intel/cve/<cve_id>`
- **Method:** GET
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Response:** CVE details.

### Fetch STIX objects from TAXII and store locally
- **URL:** `/api/intel/pull`
- **Method:** POST
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Request Body:**
```json
{
  "collection": "easm-indicators",
  "limit": 20
}
```
- **Response:** Pull status.

### List stored STIX objects
- **URL:** `/api/intel/stored`
- **Method:** GET
- **Headers:** `Authorization: Bearer <JWT_TOKEN>`
- **Response:** List of STIX objects.

## Notes

- All endpoints except signup and signin require JWT authentication.
- Use the `Authorization` header with the format: `Bearer <JWT_TOKEN>`.
- Scan jobs are processed asynchronously via Redis-backed queue.
- Rate limiting is applied to prevent abuse.
