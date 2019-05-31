using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Tarifas
    {
        public static ArrayList GetTarifasList()
        {
            var listaTarifas = new ArrayList();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetTarifasList", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                MySqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    var usr = new Dictionary<String, Object>
                    {
                        { "Id", int.Parse(rd.GetString("Id")) },
                        { "CiudadOrigen", rd.GetString("CiudadOrigen") },
                        { "CiudadDestino", rd.GetString("CiudadDestino")},
                        { "Costo", rd.GetString("Costo") }
                    };

                    listaTarifas.Add(usr);
                }
            }
            catch (Exception ex)
            {
                return null;
            }

            return listaTarifas;
        }

        public static ArrayList GetCiudadesList()
        {
            var listaCiudades = new ArrayList();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetCiudadesList", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                MySqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    var ciudad = new Dictionary<String, Object>
                    {
                        { "Id", int.Parse(rd.GetString("Id")) },
                        { "Nombre", rd.GetString("Nombre") }
                    };

                    listaCiudades.Add(ciudad);
                }
            }
            catch (Exception ex)
            {
                return null;
            }

            return listaCiudades;
        }

        public static Boolean Insert(Dictionary<String, Object> datos)
        {
            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("InsertTarifa", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@CiudadOrigen", datos["CiudadOrigen"]);
                cmd.Parameters.AddWithValue("@CiudadDestino", datos["CiudadDestino"]);
                cmd.Parameters.AddWithValue("@ValorTarifa", datos["ValorTarifa"]);


                if (cmd.ExecuteNonQuery() > 0)
                    return true;
            }
            catch (Exception ex)
            {
                return false;
            }

            return false;
        }

        public static Dictionary<String, Object> GetTarifaById(int tarifaId)
        {
            Dictionary<String, Object> tarifa = new Dictionary<String, Object>();

            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("GetTarifaById", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@TarifaId", tarifaId);

                MySqlDataReader rd = cmd.ExecuteReader();

                if (rd.Read())
                {
                    tarifa = new Dictionary<String, Object>
                    {
                        { "Id", int.Parse(rd.GetString("Id")) },
                        { "CiudadOrigen", rd.GetString("CiudadOrigen") },
                        { "CiudadDestino", rd.GetString("CiudadDestino") },
                        { "ValorTarifa", double.Parse(rd.GetString("ValorTarifa"))}
                    };
                }
            }
            catch (Exception ex)
            {
                return null;
            }

            return tarifa;
        }

        //Modificar Tarifas
        public static Boolean UpdateTarifa(Dictionary<String, Object> datosTarifa)
        {
            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("UpdateTarifa", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdTarifa", datosTarifa["IdTarifa"]);
                cmd.Parameters.AddWithValue("@CiudadOrigen", datosTarifa["CiudadOrigen"]);
                cmd.Parameters.AddWithValue("@CiudadDestino", datosTarifa["CiudadDestino"]);
                cmd.Parameters.AddWithValue("@ValorTarifa", datosTarifa["ValorTarifa"]);

                if (cmd.ExecuteNonQuery() > 0)
                    return true;
            }
            catch (Exception ex)
            {
                return false;
            }


            return false;
        }

        //Eliminar usuario
        public static Boolean DeleteTarifa(int IdTarifa)
        {
            try
            {
                Conexion con = new Conexion();
                con.Open();
                MySqlCommand cmd = new MySqlCommand("DeleteTarifa", con.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdTarifa", IdTarifa);

                if (cmd.ExecuteNonQuery() > 0)
                    return true;
            }
            catch (Exception ex)
            {
                return false;
            }
            return false;
        }
    }
}
