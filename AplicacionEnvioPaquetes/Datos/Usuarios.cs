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
        // Obtener información de usuario para ingresar al sistema
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

        //Obtener listado de todos los usuarios registrados
        public static ArrayList GetListUsers(int idUser)
        {
            var usrList = new ArrayList();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetUsersList", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdUser", idUser);

                MySqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    var usr = new Dictionary<String, Object>
                    {
                        { "Id", int.Parse(rd.GetString("Id")) },
                        { "NombreUsuario", rd.GetString("NombreUsuario") },
                        { "Documento", int.Parse(rd.GetString("Documento")) },
                        { "Email", rd.GetString("Email") },
                        { "Rol", rd.GetString("Rol") },
                        { "Estado", rd.GetString("Estado") }
                    };

                    usrList.Add(usr);
                }
            }
            catch (Exception ex)
            {
                return null;
            }

            return usrList;
        }
    }
}
