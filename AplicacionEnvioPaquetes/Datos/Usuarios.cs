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

        // Obtener información de usuario para comparación en cambio de contraseña
        public static Dictionary<String, Object> GetInfoUserSession(int IdUser)
        {
            var usr = new Dictionary<String, Object>();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetInfoUserSession", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdUser", IdUser);

                MySqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    usr.Add("Id", int.Parse(rd.GetString("Id")));
                    usr.Add("HashKey", rd.GetString("HashKey"));
                    usr.Add("PasswordUser", rd.GetString("PasswordUser"));
                }
            }
            catch (Exception ex)
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
                        { "Documento", rd.GetString("Documento")},
                        { "Email", rd.GetString("Email") },
                        { "Rol", rd.GetString("Rol") },
                        { "IdEstado", int.Parse(rd.GetString("IdEstado")) },
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

        //Obtener listado de opciones de menu por rol de usuario
        public static List<List<Dictionary<String, Object>>> GetOptionsByRole(int Role)
        {
            List<List<Dictionary<String, Object>>> list = new List<List<Dictionary<String, Object>>>();

            switch(Role)
            {
                // Administrador
                case 1:
                    list.Add(new List<Dictionary<String, Object>> {
                        new Dictionary<String, Object>() { { "LinkText", "Usuarios" } , { "LinkURL" , "/User/" } , { "LinkID" , "User" }},
                        new Dictionary<String, Object>() { { "LinkText", "Tarifas" } , { "LinkURL" , "/Tarifa/" } , { "LinkID", "Tarifa" } }
                    });
                    
                    break;
                // Operador
                case 2:
                    list.Add(new List<Dictionary<String, Object>> {
                        new Dictionary<String, Object>() { { "LinkText", "Envíos" } , { "LinkURL" , "/Envios/" } , { "LinkID" , "Envios" } }
                    });
                    break;
                // Mensajero
                case 3:
                    list.Add(new List<Dictionary<String, Object>> {
                        new Dictionary<String, Object>() { { "LinkText", "Entregas" } , { "LinkURL" , "/Entregas/" } , { "LinkID", "Entregas" } }
                    });
                    break;
                default:
                    return null;
            }

            return list;
        }

        //Retornar listado de roles de usuario
        public static ArrayList GetUserRoles()
        {
            ArrayList roles = new ArrayList();
            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetUserRoles", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;
                MySqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    var usr = new Dictionary<String, Object>
                    {
                        { "Id", int.Parse(rd.GetString("Id")) },
                        { "Nombre", rd.GetString("Nombre") }
                    };

                    roles.Add(usr);
                }
            }
            catch (Exception ex)
            {
                return null;
            }


            return roles;
        }

        //Retornar listado de estados de usuario
        public static ArrayList GetStatusList()
        {
            ArrayList status = new ArrayList();
            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetStatusList", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;
                MySqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    var usr = new Dictionary<String, Object>
                    {
                        { "Id", int.Parse(rd.GetString("Id")) },
                        { "Nombre", rd.GetString("Nombre") }
                    };

                    status.Add(usr);
                }
            }
            catch (Exception ex)
            {
                return null;
            }


            return status;
        }

        //Insertar nuevos usuarios
        public static Boolean InsertUser(Dictionary<String, Object> datosUsuario)
        {
            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("InsertUser", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@NombreUsuario", datosUsuario["NombreUsuario"]);
                cmd.Parameters.AddWithValue("@ApellidoUsuario", datosUsuario["ApellidoUsuario"]);
                cmd.Parameters.AddWithValue("@Documento", datosUsuario["Documento"]);
                cmd.Parameters.AddWithValue("@EmailUsuario", datosUsuario["EmailUsuario"]);
                cmd.Parameters.AddWithValue("@Contrasenia", datosUsuario["Contrasenia"]);
                cmd.Parameters.AddWithValue("@TelefonoUsuario", datosUsuario["TelefonoUsuario"]);
                cmd.Parameters.AddWithValue("@RolUsuario", datosUsuario["RolUsuario"]);
                cmd.Parameters.AddWithValue("@HashKey", datosUsuario["HashKey"]);

                if(cmd.ExecuteNonQuery() > 0)
                    return true;
            }
            catch (Exception ex)
            {
                return false;
            }


            return false;
        }

        //Modificar usuarios
        public static Boolean UpdateUser(Dictionary<String, Object> datosUsuario)
        {
            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("UpdateUser", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdUsuario", datosUsuario["IdUsuario"]);
                cmd.Parameters.AddWithValue("@NombreUsuario", datosUsuario["NombreUsuario"]);
                cmd.Parameters.AddWithValue("@ApellidoUsuario", datosUsuario["ApellidoUsuario"]);
                cmd.Parameters.AddWithValue("@Documento", datosUsuario["Documento"]);
                cmd.Parameters.AddWithValue("@EmailUsuario", datosUsuario["EmailUsuario"]);
                cmd.Parameters.AddWithValue("@TelefonoUsuario", datosUsuario["TelefonoUsuario"]);
                cmd.Parameters.AddWithValue("@RolUsuario", datosUsuario["RolUsuario"]);
                cmd.Parameters.AddWithValue("@EstadoUsuario", datosUsuario["EstadoUsuario"]);

                if (cmd.ExecuteNonQuery() > 0)
                    return true;
            }
            catch (Exception ex)
            {
                return false;
            }


            return false;
        }

        //Cambiar contraseña
        public static Boolean ChangePassword(Dictionary<String, Object> datosUsuario)
        {
            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("ChangePassword", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdUsuario", datosUsuario["IdUsuario"]);
                cmd.Parameters.AddWithValue("@Password", datosUsuario["Password"]);

                if (cmd.ExecuteNonQuery() > 0)
                    return true;
            }
            catch (Exception ex)
            {
                return false;
            }


            return false;
        }

        // Obtener información de usuario por Id
        public static Dictionary<String, Object> GetUserById(int UserId)
        {
            Dictionary<String, Object> userInfo = new Dictionary<String, Object>();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetUsersById", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserId", UserId);

                MySqlDataReader rd = cmd.ExecuteReader();

                if (rd.Read())
                {
                    userInfo = new Dictionary<String, Object>
                    {
                        { "Id", int.Parse(rd.GetString("Id")) },
                        { "NombreUsuario", rd.GetString("NombreUsuario") },
                        { "ApellidoUsuario", rd.GetString("ApellidoUsuario") },
                        { "Documento", rd.GetString("Documento")},
                        { "Email", rd.GetString("Email") },
                        { "Telefono", rd.GetString("Telefono") },
                        { "Rol", rd.GetString("Rol") },
                        { "IdEstado", int.Parse(rd.GetString("IdEstado")) }
                    };
                }
            }
            catch (Exception ex)
            {
                return null;
            }

            return userInfo;
        }
    }
}
