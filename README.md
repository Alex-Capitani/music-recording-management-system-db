# music-recording-management-system-db
Relational database schema for a music recording management system (MySQL) including sample data and advanced SQL queries.

# Music Recording Database

Relational database schema for a music recording environment (songs, singers, labels, recordings, people and phone numbers).  
This repository includes an installation script (schema + sample data) and query exercises.

## Requirements
- MySQL 8+ or MariaDB 10+
- A SQL client: MySQL Workbench / DBeaver / HeidiSQL

## Project Files
- `schema/01_install_schema.sql` → Creates database `musicdb`, tables and sample data (seed)
- `queries/02_queries.sql` → Query exercises (Query 01..07)
- `diagram/er-diagram.png` → ER diagram

## Installation (run locally)

### Option A — GUI (MySQL Workbench / DBeaver / HeidiSQL)
1. Connect to your local MySQL/MariaDB server.
2. Open and run: `schema/01_install_schema.sql`
3. Verify tables:
   - `SHOW TABLES;`

### Option B — Terminal (CLI)
From the repository root folder:

```bash
mysql -u root -p < schema/01_install_schema.sql

---

```

## Running the Queries

After installation, run:

- queries/02_queries.sql

If your client does not select the database automatically:

USE musicdb;
