using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AplicacionEnvioPaquetes.Controllers
{
    public class PaquetesController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Consulta(String Documento)
        {
            ViewBag.Paquetes = Paquetes.GetPacksByClient(Documento);
            return View();
        }
    }
}