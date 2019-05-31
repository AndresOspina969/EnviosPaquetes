using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace AplicacionEnvioPaquetes.Controllers
{
    public class TarifaController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            if (Session["USER_DATA"] != null)
            {
                Dictionary<String, Object> user_data = (Dictionary<String, Object>)Session["USER_DATA"];
                if (!bool.Parse(user_data["IsAuth"].ToString()))
                    return Redirect("~/Home/Index/");
                else
                    if (!user_data["RolName"].ToString().Equals("Administrador"))
                    return Redirect("~/Home/Index/");
            }
            else
            {
                return Redirect("~/Home/Index/");
            }

            ViewBag.Tarifas = Tarifas.GetTarifasList();
            return View();
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
                    if (!user_data["RolName"].ToString().Equals("Administrador"))
                    return Redirect("~/Home/Index/");
            }
            else
            {
                return Redirect("~/Home/Index/");
            }

            ViewBag.Ciudades = Tarifas.GetCiudadesList();
            return View();
        }

        [HttpPost]
        public ActionResult Register(String data)
        {
            Dictionary<String, Object> response = new Dictionary<String, Object>();
            Dictionary<String, Object> datos = new Dictionary<String, Object>();
            var result = new JavaScriptSerializer().Deserialize<dynamic>(data);

            foreach (var obj in result)
            {
                datos.Add(obj["name"], obj["value"]);
            }

            bool resp = Tarifas.Insert(datos);

            if (resp)
                response.Add("success", "true");
            else
                response.Add("error", "No se ha podido guardar el usuario.");

            return Json(response, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult Update(String tarifaId)
        {
            if (Session["USER_DATA"] != null)
            {
                Dictionary<String, Object> user_data = (Dictionary<String, Object>)Session["USER_DATA"];
                if (!bool.Parse(user_data["IsAuth"].ToString()))
                    return Redirect("~/Home/Index/");
                else
                    if (!user_data["RolName"].ToString().Equals("Administrador"))
                    return Redirect("~/Home/Index/");
            }
            else
            {
                return Redirect("~/Home/Index/");
            }

            ViewBag.Tarifa = Tarifas.GetTarifaById(int.Parse(tarifaId));
            ViewBag.Ciudades = Tarifas.GetCiudadesList();
            return View();
        }

        [HttpPost]
        public ActionResult UpdateTarifa(String data)
        {
            Dictionary<String, Object> response = new Dictionary<String, Object>();
            Dictionary<String, Object> datos = new Dictionary<String, Object>();
            var result = new JavaScriptSerializer().Deserialize<dynamic>(data);

            foreach (var obj in result)
            {
                datos.Add(obj["name"], obj["value"]);
            }
            bool resp = Tarifas.UpdateTarifa(datos);

            if (resp)
                response.Add("success", "true");
            else
                response.Add("error", "No se ha podido modificar el usuario.");

            return Json(response, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult DeleteTarifa(String tarifaId)
        {
            Dictionary<String, Object> response = new Dictionary<String, Object>();

            bool resp = Tarifas.DeleteTarifa(int.Parse(tarifaId));

            if (resp)
                response.Add("success", "true");
            else
                response.Add("error", "No se ha podido eliminar la tarifa.");

            return Json(response, JsonRequestBehavior.AllowGet);
        }
    }
}