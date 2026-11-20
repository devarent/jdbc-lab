#!/usr/bin/env bash
set -euo pipefail
export JDBC_URL="${JDBC_URL:-jdbc:postgresql://localhost:5432/lab}"
export JDBC_USER="${JDBC_USER:-lab}"
export JDBC_PASSWORD="${JDBC_PASSWORD:-labpassword}"
mvn -q compile exec:java -Dexec.mainClass=lab.JdbcLab
