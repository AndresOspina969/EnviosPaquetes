using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Datos;

namespace AplicacionEnvioPaquetes.Controllers
{
    public class HomeController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            if (Session["USER_DATA"] != null)
            {
                Dictionary<String, Object> user_data = (Dictionary<String, Object>)Session["USER_DATA"];
                if (bool.Parse(user_data["IsAuth"].ToString()))
                    switch(user_data["RolName"].ToString())
                    {
                        case "Administrador":
                            return Redirect("~/User/Index/");
                        default:
                            Session["USER_DATA"] = null;
                            return Redirect("~/Home/Index/");
                    }
                    
            }

            return View();
        }

        [HttpPost]
        public ActionResult Login(String username, String password)
        {
            Dictionary<String, Object> response = new Dictionary<String, Object>();

            var dataUser = Usuarios.GetInfoUserLogin(username);
            if (dataUser.Count != 0)
            {
                String hash = dataUser["HashKey"].ToString();
                if (Security.Encriptar(password, hash) == dataUser["PasswordUser"].ToString())
                {
                    if (int.Parse(dataUser["IdEstadoUsuario"].ToString()) == 1)
                    {
                        Dictionary<String, Object> user_data = new Dictionary<String, Object>();

                        user_data.Add("IsAuth", true);
                        user_data.Add("NombreUsuario", dataUser["Nombre"].ToString());
                        user_data.Add("IdUsuario", int.Parse(dataUser["Id"].ToString()));
                        user_data.Add("RolName", dataUser["RolName"].ToString());

                        Session.Add("USER_DATA", user_data);

                        response.Add("success", true);
                        response.Add("user_data", user_data);
                    }
                    else
                        response.Add("error", "El usuario se encuentra inactivo.");
                }
                else
                    response.Add("error", "Contraseña incorrecta.");
            }
            else
                response.Add("error", "El usuario no existe.");

            return Json(response, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult SearchPacks(String documento)
        {
            Dictionary<String, Object> response = new Dictionary<String, Object>();
            var packs = Paquetes.GetPacksByClient(documento);

            response.Add("DataPacks", packs);

            return Json(response, JsonRequestBehavior.AllowGet);
        }

    }        
}