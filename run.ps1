$env:JDBC_URL = "jdbc:postgresql://localhost:5432/lab"
$env:JDBC_USER = "lab"
$env:JDBC_PASSWORD = "labpassword"
mvn -q compile exec:java "-Dexec.mainClass=lab.JdbcLab"
