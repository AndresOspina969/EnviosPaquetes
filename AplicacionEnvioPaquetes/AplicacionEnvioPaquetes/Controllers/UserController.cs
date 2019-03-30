using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AplicacionEnvioPaquetes.Controllers
{
    public class UserController : Controller
    {
        public ActionResult Index()
        {
            if (Session["IsAuth"] != null && !bool.Parse(Session["IsAuth"].ToString()))
                return Redirect("~/Home/Index/");

            return View();
        }
    }
}