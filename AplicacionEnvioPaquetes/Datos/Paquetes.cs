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
    }
}
