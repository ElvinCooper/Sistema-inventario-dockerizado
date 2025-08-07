from sqlalchemy import create_engine, text 
import cx_Oracle
import oracledb


#oracledb.init_oracle_client(lib_dir="/usr/lib/instantclient_11_2")

cx_Oracle.init_oracle_client(lib_dir="/usr/lib/instantclient_11_2")


# Datos de conexión
username = "train7"
password = "train7"
host = "192.168.14.196"  
port = 1521
service_name = "ORCLCR1"

# Cadena de conexión
engine = create_engine(
    f"oracle+cx_oracle://{username}:{password}@{host}:{port}/?service_name={service_name}"
)

# Probar conexión
try:
    with engine.connect() as connection:
        result = connection.execute(text("SELECT * FROM EMPLES_NORMALES WHERE SALARIO > 3000"))
        for row in result:
            codigo = row[0]
            nombre = row[1]
            salario = row[2]
            Responsable = row[3]
            print(f'Codigo: {codigo} Nombre: {nombre} Salario: {salario} Responsable: {Responsable}\n')            
except Exception as err:
    print(f'Error en la conexion: {err}, {type(err)}')
