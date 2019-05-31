using Datos;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace AplicacionEnvioPaquetes.Controllers
{
    public class EnviosController : Controller
    {
        // GET: Envios
        public ActionResult Index()
        {
            if (Session["USER_DATA"] != null)
            {
                Dictionary<String, Object> user_data = (Dictionary<String, Object>)Session["USER_DATA"];
                if (!bool.Parse(user_data["IsAuth"].ToString()))
                    return Redirect("~/Home/Index/");
                else
                    if (!user_data["RolName"].ToString().Equals("Operador"))
                        return Redirect("~/Home/Index/");
            }
            else
            {
                return Redirect("~/Home/Index/");
            }

            ViewBag.Envios = Paquetes.GetAllPacks();
            return View();
        }

        [HttpPost]
        public ActionResult ShowDetails(String envio)
        {
            Dictionary<String, Object> response = new Dictionary<String, Object>();

            var dataEnvio = Paquetes.GetInfoPack(int.Parse(envio));

            if(dataEnvio.Count != 0)
            {
                response.Add("success", true);
                response.Add("datos", dataEnvio);
            }
            else
            {
                response.Add("success", false);
                response.Add("error", "Ha ocurrido un error al visualizar la información del envío.");
            }

            return Json(response, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult New()
        {
            if (Session["USER_DATA"] != null)
            {
                Dictionary<String, Object> user_data = (Dictionary<String, Object>)Session["USER_DATA"];
                if (!bool.Parse(user_data["IsAuth"].ToString()))
                    return Redirect("~/Home/Index/");
                else
                    if (!user_data["RolName"].ToString().Equals("Operador"))
                        return Redirect("~/Home/Index/");
            }
            else
            {
                return Redirect("~/Home/Index/");
            }

            ViewBag.Tarifas = Tarifas.GetTarifasList();
            return View();
        }

        [HttpPost]
        public ActionResult SaveCliente(String data)
        {
            Dictionary<String, Object> response = new Dictionary<String, Object>();
            Dictionary<String, Object> datos = new Dictionary<String, Object>();
            var result = new JavaScriptSerializer().Deserialize<dynamic>(data);

            foreach (var obj in result)
            {
                datos.Add(obj["name"], obj["value"]);
            }

            int resp = Paquetes.InsertCliente(datos);

            if (resp != 0)
            {
                response.Add("success", "true");
                response.Add("IdCliente", resp);
            }                
            else
                response.Add("error", "No se ha podido guardar el cliente.");

            return Json(response, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult GetListClients()
        {
            Dictionary<String, Object> response = new Dictionary<String, Object>();
            List<Dictionary<String, Object>> list = Paquetes.GetListClients();

            if(list.Count != 0)
            {
                response.Add("success", true);
                response.Add("data", list);
            }
            else
            {
                response.Add("success", false);
            }

            return Json(response, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult InsertNewEnvio(String data)
        {

            Dictionary<String, Object> response = new Dictionary<String, Object>();
            Dictionary<String, Object> datos = new Dictionary<String, Object>();
            var result = new JavaScriptSerializer().Deserialize<dynamic>(data);

            foreach (var obj in result)
            {
                datos.Add(obj["name"], obj["value"]);
            }

            Dictionary<String, Object> user_data = (Dictionary<String, Object>)Session["USER_DATA"];
            datos.Add("UsuarioRegistra", user_data["IdUsuario"]);

            bool resp = Paquetes.InsertEnvio(datos);

            if (resp)
            {
                response.Add("success", "true");
            }
            else
                response.Add("error", "No se ha podido guardar el envío.");

            return Json(response, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult Update(String envioId)
        {
            if (Session["USER_DATA"] != null)
            {
                Dictionary<String, Object> user_data = (Dictionary<String, Object>)Session["USER_DATA"];
                if (!bool.Parse(user_data["IsAuth"].ToString()))
                    return Redirect("~/Home/Index/");
                else
                    if (!user_data["RolName"].ToString().Equals("Operador"))
                    return Redirect("~/Home/Index/");
            }
            else
            {
                return Redirect("~/Home/Index/");
            }

            ViewBag.Paquete = Paquetes.GetEnvioInfoById(int.Parse(envioId));
            ViewBag.Tarifas = Tarifas.GetTarifasList();
            ViewBag.Estados = Paquetes.GetListEstadosPack();

            ArrayList deliveyUsers = Usuarios.GetDeliveryUser();

            if(deliveyUsers.Count != 0)
            {
                ViewBag.Mensajeros = deliveyUsers;
            }
            else
            {
                ViewBag.Mensajeros = new ArrayList();
            }

            return View();
        }

        [HttpPost]
        public ActionResult UpdateEnvio(String data)
        {

            Dictionary<String, Object> response = new Dictionary<String, Object>();
            Dictionary<String, Object> datos = new Dictionary<String, Object>();
            var result = new JavaScriptSerializer().Deserialize<dynamic>(data);

            foreach (var obj in result)
            {
                datos.Add(obj["name"], obj["value"]);
            }

            Dictionary<String, Object> user_data = (Dictionary<String, Object>)Session["USER_DATA"];
            datos.Add("UsuarioRegistra", user_data["IdUsuario"]);

            bool resp = Paquetes.UpdateEnvio(datos);

            if (resp)
            {
                response.Add("success", "true");
            }
            else
                response.Add("error", "No se ha podido guardar el envío.");

            return Json(response, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Delete(String envioId)
        {
            Dictionary<String, Object> response = new Dictionary<String, Object>();

            bool resp = Paquetes.Delete(int.Parse(envioId));

            if (resp)
                response.Add("success", "true");
            else
                response.Add("error", "No se ha podido eliminar el envío.");

            return Json(response, JsonRequestBehavior.AllowGet);
        }
    }
}