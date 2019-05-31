using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Paquetes
    {
        public static List<Dictionary<String, Object>> GetPacksByClient(String documento)
        {
            var listPacks = new List<Dictionary<String, Object>>();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetPacksByClient", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@DocumentoCliente", documento);

                MySqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    var pack = new Dictionary<String, Object>();
                    pack.Add("IdPaquete", int.Parse(rd.GetString("IdPaquete")));
                    pack.Add("Descripcion", rd.GetString("Descripcion"));
                    pack.Add("Estado", rd.GetString("Estado"));
                    pack.Add("NombreRemitente", rd.GetString("NombreRemitente"));
                    pack.Add("NombreDestinatario", rd.GetString("NombreDestinatario"));
                    pack.Add("Valor", double.Parse(rd.GetString("Valor")));
                    pack.Add("Fecha_Registro", rd.GetString("Fecha_Registro"));
                    pack.Add("Fecha_Entrega", rd.GetString("Fecha_Entrega"));
                    pack.Add("CiudadOrigen", rd.GetString("CiudadOrigen"));
                    pack.Add("CiudadDestino", rd.GetString("CiudadDestino"));

                    listPacks.Add(pack);
                }
            }
            catch (Exception ex)
            {
                return null;
            }

            return listPacks;
        }

        public static List<Dictionary<String, Object>> GetAllPacks()
        {
            var listPacks = new List<Dictionary<String, Object>>();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetAllPacks", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;


                MySqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    var pack = new Dictionary<String, Object>();
                    pack.Add("IdPaquete", int.Parse(rd.GetString("IdPaquete")));
                    pack.Add("Descripcion", rd.GetString("Descripcion"));
                    pack.Add("Estado", rd.GetString("Estado"));
                    pack.Add("NombreRemitente", rd.GetString("NombreRemitente"));
                    pack.Add("NombreDestinatario", rd.GetString("NombreDestinatario"));
                    pack.Add("Fecha_Registro", rd.GetString("Fecha_Registro"));

                    listPacks.Add(pack);
                }
            }
            catch (Exception ex)
            {
                return null;
            }

            return listPacks;
        }

        public static Dictionary<String, Object> GetInfoPack(int envioId)
        {
            Dictionary<String, Object> pack = new Dictionary<String, Object>();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetInfoPack", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdEnvio", envioId);

                MySqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    pack.Add("IdPaquete", int.Parse(rd.GetString("IdPaquete")));
                    pack.Add("Descripcion", rd.GetString("Descripcion"));
                    pack.Add("Estado", rd.GetString("Estado"));
                    pack.Add("NombreRemitente", rd.GetString("NombreRemitente"));
                    pack.Add("NombreDestinatario", rd.GetString("NombreDestinatario"));
                    pack.Add("Fecha_Registro", rd.GetString("Fecha_Registro"));
                    pack.Add("Valor", double.Parse(rd.GetString("Valor").ToString()));
                    pack.Add("Fecha_Entrega", rd.GetString("Fecha_Entrega"));
                    pack.Add("CiudadOrigen", rd.GetString("CiudadOrigen"));
                    pack.Add("CiudadDestino", rd.GetString("CiudadDestino"));
                    pack.Add("Mensajero", rd.GetString("Mensajero"));
                }
            }
            catch (Exception ex)
            {
                return null;
            }

            return pack;
        }

        public static int InsertCliente(Dictionary<String, Object> datos)
        {
            int idCliente = 0;

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("InsertCliente", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@NombreCliente", datos["NombreCliente"]);
                cmd.Parameters.AddWithValue("@ApellidosCliente", datos["ApellidosCliente"]);
                cmd.Parameters.AddWithValue("@Documento", datos["Documento"]);
                cmd.Parameters.AddWithValue("@TelefonoCliente", datos["TelefonoCliente"]);
                cmd.Parameters.AddWithValue("@DireccionCliente", datos["DireccionCliente"]);
                cmd.Parameters.Add("@IdCliente", MySqlDbType.Int32, 11);
                cmd.Parameters["@IdCliente"].Direction = ParameterDirection.Output;


                if (cmd.ExecuteNonQuery() > 0)
                {
                    idCliente = int.Parse(cmd.Parameters["@IdCliente"].Value.ToString());
                }
            }
            catch (Exception ex)
            {
                return 0;
            }

            return idCliente;
        }

        public static Boolean InsertEnvio(Dictionary<String, Object> datos)
        {
            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("InsertEnvio", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@Remitente", datos["ClienteRemitente"]);
                cmd.Parameters.AddWithValue("@Destinatario", datos["ClienteDestinatario"]);
                cmd.Parameters.AddWithValue("@UsuarioRegistra", datos["UsuarioRegistra"]);
                cmd.Parameters.AddWithValue("@Descripcion", datos["Descripcion"]);
                cmd.Parameters.AddWithValue("@Tarifa", datos["IdTarifa"]);


                if (cmd.ExecuteNonQuery() > 0)
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                return false;
            }
            return false;
        }

        public static List<Dictionary<String, Object>> GetListClients()
        {
            List<Dictionary<String, Object>> list = new List<Dictionary<String, Object>>();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetListClients", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                MySqlDataReader reader = cmd.ExecuteReader();

                while(reader.Read())
                {
                    Dictionary<String, Object> client = new Dictionary<String, Object>();

                    client.Add("IdCliente", reader.GetInt32("IdCliente"));
                    client.Add("NombresCliente", reader.GetString("NombresCliente"));
                    client.Add("Documento", reader.GetString("Documento"));

                    list.Add(client);
                }
            }
            catch (Exception ex)
            {
                return null;
            }

            return list;
        }

        public static Dictionary<String, Object> GetEnvioInfoById(int envioId)
        {
            Dictionary<String, Object> envio = new Dictionary<String, Object>();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetEnvioInfoById", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdEnvio", envioId);

                MySqlDataReader rd = cmd.ExecuteReader();

                if (rd.Read())
                {
                    envio = new Dictionary<String, Object>
                    {
                        { "Id", int.Parse(rd.GetString("Id")) },
                        { "NombreRemitente", rd.GetString("NombreRemitente") },
                        { "DocumentoRemitente", rd.GetString("DocumentoRemitente") },
                        { "NombreDestinatario", rd.GetString("NombreDestinatario")},
                        { "DocumentoDestinatario", rd.GetString("DocumentoDestinatario")},
                        { "IdTarifa", int.Parse(rd.GetString("IdTarifa"))},
                        { "Descripcion", rd.GetString("Descripcion")},
                        { "IdEstado", int.Parse(rd.GetString("IdEstado"))},
                        { "FechaEntrega", rd.GetString("FechaEntrega")},
                        { "UsuarioMensajero", rd.GetString("UsuarioMensajero")},
                        { "IdMensajero", rd.GetString("IdMensajero")}
                    };
                }
            }
            catch (Exception ex)
            {
                return null;
            }

            return envio;
        }

        public static List<Dictionary<String, Object>> GetListEstadosPack()
        {
            List<Dictionary<String, Object>> list = new List<Dictionary<String, Object>>();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetListEstadosPack", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                MySqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Dictionary<String, Object> client = new Dictionary<String, Object>();

                    client.Add("Id", reader.GetInt32("Id"));
                    client.Add("NombresEstado", reader.GetString("NombresEstado"));

                    list.Add(client);
                }
            }
            catch (Exception ex)
            {
                return null;
            }

            return list;
        }

        public static Boolean UpdateEnvio(Dictionary<String, Object> datos)
        {
            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("UpdateEnvio", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdEnvio", datos["IdEnvio"]);
                cmd.Parameters.AddWithValue("@Descripcion", datos["Descripcion"]);
                cmd.Parameters.AddWithValue("@Tarifa", datos["Tarifa"]);
                cmd.Parameters.AddWithValue("@EstadoPaquete", datos["EstadoPaquete"]);
                cmd.Parameters.AddWithValue("@Mensajero", datos["Mensajero"]);


                if (cmd.ExecuteNonQuery() > 0)
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                return false;
            }

            return false;
        }

        public static Boolean EntregaPaquete(int IdPaquete)
        {
            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("EntregaPaquete", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdPaquete", IdPaquete);


                if (cmd.ExecuteNonQuery() > 0)
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                return false;
            }

            return false;
        }
        public static Boolean Delete(int IdEnvio)
        {
            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("DeleteEnvio", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdEnvio", IdEnvio);

                if (cmd.ExecuteNonQuery() > 0)
                    return true;
            }
            catch (Exception ex)
            {
                return false;
            }
            return false;
        }

        // --------------------------------
        public static List<Dictionary<String, Object>> GetAllPacksByDelivery(int IdMensajero)
        {
            var listPacks = new List<Dictionary<String, Object>>();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetAllPacksByDelivery", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdMensajero", IdMensajero);

                MySqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    var pack = new Dictionary<String, Object>();
                    pack.Add("IdPaquete", int.Parse(rd.GetString("IdPaquete")));
                    pack.Add("Descripcion", rd.GetString("Descripcion"));
                    pack.Add("NombreRemitente", rd.GetString("NombreRemitente"));
                    pack.Add("NombreDestinatario", rd.GetString("NombreDestinatario"));
                    pack.Add("Fecha_Registro", rd.GetString("Fecha_Registro"));
                    pack.Add("CiudadOrigenDestino", rd.GetString("CiudadOrigenDestino"));

                    listPacks.Add(pack);
                }
            }
            catch (Exception ex)
            {
                return null;
            }

            return listPacks;
        }
    }
}
