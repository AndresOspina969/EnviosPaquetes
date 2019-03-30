using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace Datos
{
    public class Conexion
    {
        private MySqlConnection conexion = null;     
        
        public Conexion() { }

        public bool Open()
        {
            String host = "localhost";
            String dbName = "envios";
            String username = "root";
            String pass = "";

            try
            {
                conexion = new MySqlConnection();
                conexion.ConnectionString = String.Format("Server={0};Database={1}; Uid={2};Pwd={3};", host, dbName, username, pass);
                conexion.Open();
            }
            catch(Exception ex)
            {
                String message = ex.Message;
                return false;
            }

            return true;
        }

        public MySqlConnection GetConnection()
        {
            return conexion;
        }

        public void Close()
        {
            if(conexion != null)
            {
                conexion.Close();
            }
        }
    }
}
