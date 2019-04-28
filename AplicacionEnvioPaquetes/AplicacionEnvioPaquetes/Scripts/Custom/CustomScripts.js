$(document).ready(function () {


    // Inicio de sesión en la aplicación
    $("#login-form").on("submit", function (e) {
        e.preventDefault();

        var errorMsg = $(this).find(".error-message");
        errorMsg.fadeOut();

        var count = 0;
        $(this).find(".required-input").each(function () {
            if ($(this).val() === "" || $(this).val().length == 0) {
                count++;
            }
        });

        if (count !== 0) {
            errorMsg.html("Complete los campos del formulario!").fadeIn(150);
        } else {
            var urlService = "/Home/Login/";
            var dataSend = {
                username: $("#username").val(),
                password: $("#user_password").val()
            };

            $.ajax({
                url: urlService,
                type: "POST",
                data: dataSend,
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    if (data.success != undefined) {
                        if (data.user_data) {
                            var urlRedirect = null;
                            switch (data.user_data["RolName"]) {
                                case "Administrador":
                                    urlRedirect = "/User/Index";
                                    break;
                                case "Operador":
                                    urlRedirect = "/Paquetes/Index";
                                    break;
                                case "Mensajero":
                                    urlRedirect = "/Envios/Index";
                                    break;
                            }

                            window.location = urlRedirect;
                        }
                    }else {
                        errorMsg.html(data.error).fadeIn(150);
                    }
                },
                error: function (xhr) {
                    console.log(xhr);
                }
            });
        }
    });

    $("#searchPacks").on("keypress keyup blur",function (event) {    
        $(this).val($(this).val().replace(/[^\d].+/, ""));
        if ((event.which < 48 || event.which > 57)) {
            event.preventDefault();
        }
    });

    //Consulta de paquetes por cliente
    $("#searchPacksForm").on("submit", function (e) {
        e.preventDefault();

        var errorMsg = $(this).find(".error-message");
        errorMsg.fadeOut();
        var toast = $(".toast");

        var count = 0;
        $(this).find(".required-input").each(function () {
            if ($(this).val() === "" || $(this).val().length == 0) {
                count++;
            }
        });

        if (count !== 0) {
            errorMsg.html("Ingrese el documento para consultar.").fadeIn(150);
        } else {
            var urlService = "/Home/SearchPacks/";
            var dataSend = {
                documento: $("#searchPacks").val()
            };

            $.ajax({
                url: urlService,
                type: "POST",
                data: dataSend,
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    if(data.DataPacks != 0){
                        window.location = "/Paquetes/Consulta?Documento=" + $("#searchPacks").val() ;
                    }else{
                        toast.find("#toast_title").html("Alerta!");
                        toast.find(".toast_body").html("No cuenta con envíos relacionados al documento ingresado.");                           
                        toast.fadeIn(250);
                        toast.css("backgroundColor", "#F56565");

                        setTimeout(function(){
                            toast.fadeOut(250);
                        },10000);

                    }          
                },
                error: function (xhr) {
                    console.log(xhr);
                }
            });
        }
    });

    //------------
    $("#table-dinamic").DataTable({
        dom: 'Bfrtip',
        buttons: [],
        "pagingType": "full_numbers",
        "language": {
            "search": "Busqueda:",
            "paginate": {
                "previous": "Anterior",
                "next": "Siguiente",
                "first" : "Primera",
                "last" : "Ultima"
            },
            "lengthMenu": "",
            "zeroRecords": "No existen datos de acuerdo a su busqueda.",
            "info": "Cantidad de registros: _MAX_",
            "infoEmpty": "No se han encontrado registros.",
            "infoFiltered": ""
        }
    });

    // ---------------------------------------------
    // Validaciones de formulario de registro de usuarios

    $("#form-singup").on("submit", function(e){
        e.preventDefault();
        var form = $(this);

        var errMsg = $(this).find(".error-message");
        var succMsg = $(this).find(".success-message");

        errMsg.hide();
        succMsg.hide();

        var countErr = 0;
        var err = false;

        $(".required-label").each(function(){

            var container = $(this).parent();
            var el = $(container).find(".form-control");

            var type = el[0].tagName;
            if(type == "INPUT"){
                if($(el).val() == "" || $(el).val().length == 0){
                    countErr++;
                }else{
                    if($(el).attr("emailVal") != undefined){
                        if(!validateEmailStructure($(el).val())){
                            err = true;
                        }
                    }
                }
            }else if(type = "SELECT"){
                if($(el).val() == "no-value" || $(el).val() == 0){
                    countErr++;
                }
            }
        });

        if(countErr != 0 && !err){
            errMsg.fadeIn(250).html("Complete los campos requeridos.");
        }else if(err){
            errMsg.fadeIn(250).html("Formato incorrecto del correo electrónico.");
        }else if($("#Contrasenia").val() != $("#VerificacionContrasenia").val() ){
            errMsg.fadeIn(250).html("Las contraseñas no coinciden.");
        }else{
            var urlService = "/User/SignUp/";
            var dataSend = {
                data: JSON.stringify( $(form).serializeArray() )
            };

            $.ajax({
                url : urlService,
                type: "POST",
                data: dataSend,
                dataType: "json",
                success: function (response) {
                    if (response.success != undefined) {
                        succMsg.fadeIn(250).html("Usuario registrado satisfactoriamente.");

                        setTimeout(function(){
                            window.location = "/User/Index/";
                        }, 860);
                    }else{
                        errMsg.fadeIn(250).html(response.error);
                    }
                },
                error : function(err, xhr){
                    errMsg.fadeIn(250).html("Ha ocurrido un error.");
                    console.log(xhr);
                }
            });

        }
    });

    var validateEmailStructure = function(text){
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(String(text).toLowerCase());
    };

});

function validateNumber(){
    var code = this.event.keyCode;
    if ((code<48||code>57)
      && code!==46 
      && code!==8 
      && code!==9
      && code!==37
      && code!==39)
    {
        this.event.preventDefault();        
    }
}



