using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace AplicacionEnvioPaquetes.Controllers
{
    public class EntregasController : Controller
    {
        // GET: Entregas
        public ActionResult Index()
        {
            Dictionary<String, Object> user_data; 
            if (Session["USER_DATA"] != null)
            {
                user_data = (Dictionary<String, Object>)Session["USER_DATA"];
                if (!bool.Parse(user_data["IsAuth"].ToString()))
                    return Redirect("~/Home/Index/");
                else
                    if (!user_data["RolName"].ToString().Equals("Mensajero"))
                    return Redirect("~/Home/Index/");
            }
            else
            {
                return Redirect("~/Home/Index/");
            }

            var lista = Paquetes.GetAllPacksByDelivery(int.Parse(user_data["IdUsuario"].ToString()));
            if(lista.Count != 0)
            {
                ViewBag.Pendientes = lista;
            }
            else
            {
                List<Dictionary<String, Object>> listaVacia = new List<Dictionary<String, Object>>();
                ViewBag.Pendientes = listaVacia;
            }


            return View();
        }

        [HttpPost]
        public ActionResult EntregaPaquete(String IdPaquete)
        {

            Dictionary<String, Object> response = new Dictionary<String, Object>();
            
            bool resp = Paquetes.EntregaPaquete(int.Parse(IdPaquete));

            if (resp)
            {
                response.Add("success", "true");
            }
            else
                response.Add("error", "No se ha podido guardar el estado del envío.");

            return Json(response, JsonRequestBehavior.AllowGet);
        }
    }
}