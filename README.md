<div align="center">
<img src="assets/brand-logo.svg" alt="Arya Fatthurahman" width="120" />
</div>

# JDBC Lab

<sub>Connect a plain Java 21 application to PostgreSQL and H2 with JDBC, then inspect metadata and run prepared statements.</sub>

<p>
  <img src="https://img.shields.io/badge/Database-JDBC-ED8B00?style=flat-square" alt="Database: JDBC" />
  <img src="https://img.shields.io/badge/Category-Database%20driver%20%2F%20Java-6366F1?style=flat-square" alt="Category: Database driver / Java" />
  <img src="https://img.shields.io/badge/Runs%20in-Docker-2496ED?style=flat-square&logo=docker&logoColor=white" alt="Runs in Docker" />
  <img src="https://img.shields.io/badge/License-MIT-22C55E?style=flat-square" alt="License: MIT" />
  <a href="https://github.com/devarent/jdbc-lab/actions/workflows/ci.yml"><img src="https://github.com/devarent/jdbc-lab/actions/workflows/ci.yml/badge.svg" alt="ci" /></a>
</p>

## What this lab is

JDBC is the contract between Java applications and relational databases. This lab shows the smallest useful example: one connection, one table, a prepared insert, a query, and the database metadata. It also collects the JDBC URL patterns you need for the other engines in this collection.

## Quickstart

```bash
docker compose up -d
# requires JDK 21 and Maven 3.9+
mvn -q compile exec:java -Dexec.mainClass=lab.JdbcLab
# or run against H2 without Docker:
JDBC_URL='jdbc:h2:mem:lab;DB_CLOSE_DELAY=-1' JDBC_USER=sa JDBC_PASSWORD='' mvn -q compile exec:java -Dexec.mainClass=lab.JdbcLab
```

## Connection details

| Field | Value |
| --- | --- |
| PostgreSQL URL | `jdbc:postgresql://localhost:5432/lab` |
| PostgreSQL user | `lab` |
| PostgreSQL password | `labpassword` |
| H2 in-memory URL | `jdbc:h2:mem:lab;DB_CLOSE_DELAY=-1` |
| H2 user | `sa` |
| H2 password | `(empty)` |

## Examples

| File | What it shows |
| --- | --- |
| [`docker-compose.yml`](docker-compose.yml) | Engine, ports, and persistent volume. |
| [`.github/workflows/ci.yml`](.github/workflows/ci.yml) | Builds the Java project with Maven on every push. |
| [`examples/schema.sql`](examples/schema.sql) | Table used by the Java example and by the PostgreSQL container on first start. |
| [`src/main/java/lab/JdbcLab.java`](src/main/java/lab/JdbcLab.java) | A complete JDBC workflow: connect, create, insert, query, print metadata. |
| [`pom.xml`](pom.xml) | Java 21 build with the PostgreSQL and H2 drivers and the exec plugin. |
| [`run.ps1`](run.ps1) | Windows helper. Starts nothing; run `docker compose up -d` first. |
| [`run.sh`](run.sh) | Linux/macOS helper. Starts nothing; run `docker compose up -d` first. |

## Exercises

1. Change `JDBC_URL` to the H2 URL and run the same code without PostgreSQL.
2. Print `DatabaseMetaData.getDriverName()` and `getJDBCMajorVersion()`.
3. Use `addBatch()` and `executeBatch()` to insert 100 rows in one round trip.
4. Try a wrong password and catch `SQLException`, printing the SQLState and vendor code.

## Notes and limits

- Requires JDK 21 and Maven 3.9+. The CI workflow builds with `mvn -B -q -DskipTests package`.
- The PostgreSQL container creates the `lab_notes` table on first start from `examples/schema.sql`.
- JDBC URL patterns for other engines are listed in the README table below.
- This is a local lab. Do not use these credentials anywhere public.

## Run it from anywhere

This lab publishes its ports on `127.0.0.1` only. To use it from another country, do **not** open the database port to the internet. Pick one:

- **VPS + private tunnel:** run the lab on a small Ubuntu VPS, keep the port closed, and connect through WireGuard or `ssh -L`.
- **Managed service:** use a managed free tier for this engine and point the same examples at its connection string.
- **HTTP UI only:** if the engine has a web UI, put it behind Caddy with TLS and basic auth.

The shared checklist, provider map, and commands are in **[REMOTE-ACCESS.md](https://github.com/devarent/database-labs/blob/main/REMOTE-ACCESS.md)**.

## Cleanup

```bash
docker compose down -v
```

`-v` also removes the named volume, so the next start is a clean slate.

## References

- [JDBC API documentation](https://docs.oracle.com/en/java/javase/21/docs/api/java.sql/java/sql/package-summary.html)
- [PostgreSQL JDBC driver](https://jdbc.postgresql.org/documentation/)
- [H2 database](https://h2database.com/html/main.html)

---

<sub>Part of the <a href="https://github.com/devarent/database-labs">database-labs</a> collection: 26 database engines, one index.</sub>

## License

MIT (c) 2026 Arya Fatthurahman. See [LICENSE](LICENSE).
