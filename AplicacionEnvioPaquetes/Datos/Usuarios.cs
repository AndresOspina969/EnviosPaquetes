using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace Datos
{
    public class Usuarios
    {
        public static Dictionary<String, Object> GetInfoUserLogin(String email)
        {
            var usr = new Dictionary<String, Object>();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetInfoUserLogin", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserName", email);
                
                MySqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    usr.Add("Id", int.Parse(rd.GetString("Id")));
                    usr.Add("Nombre", rd.GetString("Nombre"));
                    usr.Add("Documento", int.Parse(rd.GetString("Documento")));
                    usr.Add("HashKey", rd.GetString("HashKey"));
                    usr.Add("PasswordUser", rd.GetString("PasswordUser"));
                    usr.Add("RolName", rd.GetString("RolName"));
                    usr.Add("Rol", int.Parse(rd.GetString("Rol")));
                    usr.Add("EstadoUsuario", rd.GetString("EstadoUsuario"));
                    usr.Add("IdEstadoUsuario", int.Parse(rd.GetString("IdEstadoUsuario")));
                }
            }
            catch(Exception ex)
            {
                return null;
            }

            return usr;
        }
    }
}
