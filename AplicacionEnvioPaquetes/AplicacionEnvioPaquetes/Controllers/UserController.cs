using Datos;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Formatting;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace AplicacionEnvioPaquetes.Controllers
{
    public class UserController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            int userId = 0;

            if (Session["USER_DATA"] != null)
            {
                Dictionary<String, Object> user_data = (Dictionary<String, Object>)Session["USER_DATA"];
                if (!bool.Parse(user_data["IsAuth"].ToString()))
                    return Redirect("~/Home/Index/");
                else
                    if(!user_data["RolName"].ToString().Equals("Administrador"))
                        return Redirect("~/Home/Index/");

                userId = int.Parse(user_data["IdUsuario"].ToString());
            }
            else
            {
                return Redirect("~/Home/Index/");
            }

            ViewBag.Usuarios = Usuarios.GetListUsers(userId);
            return View();
        }

        [HttpGet]
        public ActionResult LogOut()
        {
            Session["USER_DATA"] = null;
            return Redirect("~/Home/Index/");
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
                    if(!user_data["RolName"].ToString().Equals("Administrador"))
                        return Redirect("~/Home/Index/");
            }
            else
            {
                return Redirect("~/Home/Index/");
            }

            ViewBag.Roles = Usuarios.GetUserRoles();
            return View();
        }

        [HttpPost]
        public ActionResult SignUp(String data)
        {
            Dictionary<String, Object> response = new Dictionary<String, Object>();
            Dictionary<String, Object> datos = new Dictionary<String, Object>();
            var result = new JavaScriptSerializer().Deserialize<dynamic>(data);
                       
            foreach(var obj in result)
            {
                datos.Add(obj["name"], obj["value"]);
            }

            datos.Add("HashKey", Security.GenerateRandomKey());
            datos["Contrasenia"] = Security.Encriptar(datos["Contrasenia"].ToString(), datos["HashKey"].ToString());

            bool resp = Usuarios.InsertUser(datos);

            if(resp)
                response.Add("success", "true");
            else
                response.Add("error", "No se ha podido guardar el usuario.");

            return Json(response, JsonRequestBehavior.AllowGet);
        }

    }
}