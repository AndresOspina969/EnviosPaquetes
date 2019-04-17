using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

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
    }
}