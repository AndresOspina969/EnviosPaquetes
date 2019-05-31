var INPUT_CLIENT = null;
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
                                    urlRedirect = "/Envios/Index";
                                    break;
                                case "Mensajero":
                                    urlRedirect = "/Entregas/Index";
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

    $(".btnEntrega").on("click", function(e){
        e.preventDefault();

        var idConfirmaPaquete = $(this).attr("id");
        $(".modal-confirm").fadeIn(250);
        $(".btnAceptarEntrega").attr("idConfirm", idConfirmaPaquete);
    });

    $(".btnAceptarEntrega").on("click", function(e){
        e.preventDefault();
        var id = $(this).attr("idConfirm");
        $.ajax({
            url: "/Entregas/EntregaPaquete/",
            type: "POST",
            data: { IdPaquete : id},
            dataType: "json",
            success: function (data) {
                console.log(data);
                if(data.success){
                    setTimeout(function(){
                        window.location = "/Entregas/Index/";
                    }, 1260);
                }else{
                   $(".modal-confirm").find(".error-message").html(data.error);
                }          
            },
            error: function (xhr) {
                $(".modal-confirm").find(".error-message").html("Ha ocurrido un error.");
                console.log(xhr);
            }
        });
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
                        }, 1260);
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

    // Validaciones de formulario de modificación de usuarios

    $("#form-updateUser").on("submit", function(e){
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
        }else{
            var urlService = "/User/UpdateUser/";
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
                        succMsg.fadeIn(250).html("Usuario modificado satisfactoriamente.");

                        setTimeout(function(){
                            window.location = "/User/Index/";
                        }, 1260);
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

    // Validaciones de formulario de cambio de contraseña

    $("#form-changePassword").on("submit", function(e){
        e.preventDefault();
        var form = $(this);

        var errMsg = $(this).find(".error-message");
        var succMsg = $(this).find(".success-message");

        errMsg.hide();
        succMsg.hide();

        var countErr = 0;

        $(".required-label").each(function(){

            var container = $(this).parent();
            var el = $(container).find(".form-control");

            var type = el[0].tagName;
            if(type == "INPUT"){
                if($(el).val() == "" || $(el).val().length == 0){
                    countErr++;
                }
            }
        });

        if(countErr != 0){
            errMsg.fadeIn(250).html("Complete los campos requeridos.");
        }else if($("#NuevaContrasena").val() != $("#VerificacionContrasena").val() ){
            errMsg.fadeIn(250).html("Las contraseñas no coinciden.");
        }else{
            var urlService = "/User/ChangePassword/";
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
                        succMsg.fadeIn(250).html("Contraseña modificada satisfactoriamente.");

                        setTimeout(function(){
                            window.location = "/";
                        }, 1260);
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

    var urlDeleteData = "";
    var dataDelete = {};

    // Eliminación de usuarios
    $(".deleteUserBtn").bind("click", function(e){
        e.preventDefault();
        var userId = $(this).attr("id");
        var modal = $(".modal-delete") ;
        modal.fadeIn(250);     

        urlDeleteData = "/User/DeleteUser/";
        dataDelete = { userId :  userId}
    });

    $(".deleteTarifaBtn").bind("click", function(e){
        e.preventDefault();
        var idTarifa = $(this).attr("id");
        var modal = $(".modal-delete");
        modal.fadeIn(250);

        urlDeleteData = "/Tarifa/DeleteTarifa/";
        dataDelete = { tarifaId : idTarifa}
    });

    $(".deleteEnvioBtn").bind("click", function(e){
        e.preventDefault();
        var idEnvio = $(this).attr("id");
        var modal = $(".modal-delete");
        modal.fadeIn(250);

        urlDeleteData = "/Envios/Delete/";
        dataDelete = { envioId : idEnvio}
    });

    

    //Validar fecha correcta
    Date.prototype.isValid = function () { return this.getTime() === this.getTime();};  

    $(".btnAceptar").on("click", function(e){
        e.preventDefault();

        var errMsg = $(".modal_content .error-message");
        var succMsg = $(".modal_content .success-message");

        $.ajax({
            url : urlDeleteData,
            type: "POST",
            data: dataDelete,
            dataType: "json",
            success: function (response) {
                if (response.success != undefined) {
                    succMsg.fadeIn(250).html("Se ha eliminado satisfactoriamente el registro.");

                    setTimeout(function(){
                        location.reload();
                    }, 1260);
                }else{
                    console.log(response.error);
                }
            },
            error : function(err, xhr){
                errMsg.fadeIn(250).html("Ha ocurrido un error.");
                console.log(xhr);
            }
        });

    });

    $(".cerrarModal").on("click", function(e){
        e.preventDefault();
        var modalw = $(this).parent().parent().parent();
        console.log(modalw);

        var errMsg = $(modalw).find(".error-message");
        var succMsg = $(modalw).find(" .success-message");

        errMsg.fadeOut(250).html("");
        succMsg.fadeOut(250).html("");

        if($(this).hasClass('btn'))
            modalw = $(modalw).parent();

        $(modalw).fadeOut(250).find(".modal-window .modal-content-box .modal-buttons .btnAceptar").attr("idDataDelete", 0);

        $(".list-details li").each(function(){
            $(this).find("p").html("");
        });
    });

    $(".btn-view-details").bind("click", function(e){
        e.preventDefault();
        var idEnvio = $(this).attr("id");
        var modal = $(".modal-details");
        

        urlDeleteData = "/Envios/ShowDetails/" ;
        datos = { envio : idEnvio}

        $.ajax({
            url : urlDeleteData,
            type: "POST",
            data: datos,
            dataType: "json",
            success: function (response) {
                if(response.success){
                    var c = 0;
                    for(var i in response.datos){
                        var keys = Object.keys(response.datos);
                        if(keys[c] == "Mensajero"){
                            if($.trim(response.datos[i]) == ""){
                                $(".list-details #View_" + keys[c]).parent().hide();
                            }
                        }else if( keys[c] == "Fecha_Entrega"){
                            var FechaEntrega = new Date(response.datos[i]);
                            if(!FechaEntrega.isValid())
                                $(".list-details #View_" + keys[c]).parent().hide();
                        }
                        
                        
                        $(".list-details #View_" + keys[c]).html(response.datos[i]);
                        
                        c++;
                    }

                    modal.fadeIn(250);
                }
            },
            error : function(error, xhr){}
        });
    });

    // ---------------------------------------------
    // Validaciones de formulario de registro de tarifas

    $("#form-createTarifa").on("submit", function(e){
        e.preventDefault();
        var form = $(this);

        var errMsg = $(this).find(".error-message");
        var succMsg = $(this).find(".success-message");

        errMsg.hide();
        succMsg.hide();

        var countErr = 0;

        $(".required-label").each(function(){

            var container = $(this).parent();
            var el = $(container).find(".form-control");

            var type = el[0].tagName;
            if(type == "INPUT"){
                if($(el).val() == "" || $(el).val().length == 0){
                    countErr++;
                }
            }else if(type = "SELECT"){
                if($(el).val() == "no-value" || $(el).val() == 0){
                    countErr++;
                }
            }
        });

        if(countErr != 0){
            errMsg.fadeIn(250).html("Complete los campos requeridos.");
        }else{
            var urlService = "/Tarifa/Register/";
            var dataSend = {
                data: JSON.stringify( $(form).serializeArray() )
            };

            $.ajax({
                url : urlService,
                type: "POST",
                data: dataSend,
                dataType: "json",
                success: function (response) {
                    console.log(response);
                    if (response.success != undefined) {
                        succMsg.fadeIn(250).html("Tarifa registrada satisfactoriamente.");

                        setTimeout(function(){
                            window.location = "/Tarifa/Index/";
                        }, 1260);
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

    // ---------------------------------------------
    // Validaciones de formulario de modificación de tarifas

    $("#form-updateTarifa").on("submit", function(e){
        e.preventDefault();
        var form = $(this);

        var errMsg = $(this).find(".error-message");
        var succMsg = $(this).find(".success-message");

        errMsg.hide();
        succMsg.hide();

        var countErr = 0;

        $(".required-label").each(function(){

            var container = $(this).parent();
            var el = $(container).find(".form-control");

            var type = el[0].tagName;
            if(type == "INPUT"){
                if($(el).val() == "" || $(el).val().length == 0){
                    countErr++;
                }
            }else if(type = "SELECT"){
                if($(el).val() == "no-value" || $(el).val() == 0){
                    countErr++;
                }
            }
        });

        if(countErr != 0){
            errMsg.fadeIn(250).html("Complete los campos requeridos.");
        }else{
            var urlService = "/Tarifa/UpdateTarifa/";
            var dataSend = {
                data: JSON.stringify( $(form).serializeArray() )
            };

            $.ajax({
                url : urlService,
                type: "POST",
                data: dataSend,
                dataType: "json",
                success: function (response) {
                    console.log(response);
                    if (response.success != undefined) {
                        succMsg.fadeIn(250).html("Tarifa modificada satisfactoriamente.");

                        setTimeout(function(){
                            window.location = "/Tarifa/Index/";
                        }, 1260);
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

    // ----------------------------------------------
    // Listado de clientes
    
    $(".btnSearch").on("click", function(e){
        e.preventDefault();
        var btn = $(this);
        INPUT_CLIENT = btn.attr("data-origin");

        fillTableListClient();
        $(".modal-select-client").fadeIn(250);

    });

    var fillTableListClient = function(){
        var urlService = "/Envios/GetListClients/";
        $.ajax({
            url : urlService,
            type: "POST",
            data: '',
            dataType: "json",
            success: function (response) {
                if(response.success){
                    var htmlBody = "";
                    for(var i in response.data){
                        var data = response.data[i];
                        htmlBody += "<tr>";
                        htmlBody += "<td>" + data.IdCliente + "</td>";
                        htmlBody += "<td>" + data.NombresCliente + "</td>";
                        htmlBody += "<td>" + data.Documento + "</td>";
                        htmlBody += "<td><span class='btn btn-info' onclick='selectClient(this)' docClient='" + data.Documento + "' idClient='" + data.IdCliente + "'>Seleccionar</span></td>";
                        htmlBody += "</tr>";
                    }

                    $("#tableBody").html(htmlBody);
                }
            },
            error: function(error, xhr){

            }
        });
    };    

   

    $("#showWindowsCreateClient").on("click", function(e){
        e.preventDefault();
        $(".modal-create-client").fadeIn(250);
    });


    // ----------------------------------------------
    // Validaciones formulario creacion clientes
    $(".btnSaveClient").on("click", function(e){
        e.preventDefault();
        $("#form-createCliente").submit();
    });


    $("#form-createCliente").on("submit", function(e){
        e.preventDefault();

        var urlService = "/Envios/SaveCliente/";
        var form = $(this);

        var errMsg = $(this).find(".error-message");
        var succMsg = $(this).find(".success-message");

        errMsg.hide();
        succMsg.hide();

        var countErr = 0;

        $(this).find(".required-label").each(function(){

            var container = $(this).parent();
            var el = $(container).find(".form-control");

            var type = el[0].tagName;
            if(type == "INPUT"){
                if($(el).val() == "" || $(el).val().length == 0){
                    countErr++;
                }
            }
        });

        if(countErr != 0){
            errMsg.fadeIn(250).html("Complete los campos requeridos.");
        }else{
            var dataSend = {
                data: JSON.stringify( $(form).serializeArray() )
            };
            var docuC = $(form).find("input[name='Documento']").val();

            $.ajax({
                url : urlService,
                type: "POST",
                data: dataSend,
                dataType: "json",
                success: function (response) {
                    if (response.success != undefined) {
                        succMsg.fadeIn(250).html("Cliente creado satisfactoriamente.");

                        setTimeout(function(){
                            $(form).find(".form-control").val("");
                            $(".modal-create-client").fadeOut(250);
                            fillTableListClient();
                            selectClientDinamic(response.IdCliente, docuC);

                        }, 1260)

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

    $("#form-newEnvio").on("submit", function(e){
        e.preventDefault();
        var form = $(this);

        var errMsg = $(this).find(".error-message");
        var succMsg = $(this).find(".success-message");

        errMsg.hide();
        succMsg.hide();

        var countErr = 0;

        $(form).find(".required-label").each(function(){

            var container = $(this).parent();
            var el = $(container).find(".form-control");

            var type = el[0].tagName;
            if(type == "INPUT" || type == "TEXTAREA"){
                if($(el).val() == "" || $(el).val().length == 0){
                    countErr++;
                }
            }else if(type = "SELECT"){
                if($(el).val() == "no-value" || $(el).val() == 0){
                    countErr++;
                }
            }
        });

        if(countErr != 0){
            errMsg.fadeIn(250).html("Complete los campos requeridos.");
        }else{
            var urlService = "/Envios/InsertNewEnvio/";
            var dataSend = {
                data: JSON.stringify( $(form).serializeArray() )
            };

            $.ajax({
                url : urlService,
                type: "POST",
                data: dataSend,
                dataType: "json",
                success: function (response) {
                    console.log(response);
                    if (response.success != undefined) {
                        succMsg.fadeIn(250).html("Envio registrado satisfactoriamente.");

                        setTimeout(function(){
                            window.location = "/Envios/Index/";
                        }, 1260);
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

    $("#form-updateEnvio").on("submit", function(e){
        e.preventDefault();
        var form = $(this);

        var errMsg = $(this).find(".error-message");
        var succMsg = $(this).find(".success-message");

        errMsg.hide();
        succMsg.hide();

        var countErr = 0;

        $(form).find(".required-label").each(function(){

            var container = $(this).parent();
            var el = $(container).find(".form-control");

            var type = el[0].tagName;
            if(type == "INPUT" || type == "TEXTAREA"){
                if($(el).val() == "" || $(el).val().length == 0){
                    countErr++;
                }
            }else if(type = "SELECT"){
                if($(el).val().toUpperCase() == "NO-VALUE" || $(el).val() == 0){
                    countErr++;
                }
            }
        });

        if(countErr != 0){
            errMsg.fadeIn(250).html("Complete los campos requeridos.");
        }else{
            var urlService = "/Envios/UpdateEnvio/";
            var dataSend = {
                data: JSON.stringify( $(form).serializeArray() )
            };

            $.ajax({
                url : urlService,
                type: "POST",
                data: dataSend,
                dataType: "json",
                success: function (response) {
                    console.log(response);
                    if (response.success != undefined) {
                        succMsg.fadeIn(250).html("Envio modificado satisfactoriamente.");

                        setTimeout(function(){
                            window.location = "/Envios/Index/";
                        }, 1260);
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

    $("#EstadoPaquete-Update").on("change", function(){
        if($(this).val() == "3"){
            $("#contentMensajero").fadeIn(250).find("label").addClass('required-label');
        }else{
            $("#contentMensajero").fadeOut(250).find("label").removeClass('required-label');

        }
    });

    $("#OrigenDestinoEnvio").on("change", function(){
        $("input[name='IdTarifa']").val($(this).val());
        $("#Costo").val("$" + $(this).find('option:selected').attr("costoTarifa"));
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

function selectClient(e){
    var clientId = $(e).attr("IdClient");
    var docClient = $(e).attr("docClient");
    $("#" + INPUT_CLIENT).val(docClient);
    $("input[name='" + INPUT_CLIENT +"']").val(clientId);
    $(".modal-select-client").find(".cerrarModal").click();
}

function selectClientDinamic(id, doc){
    $("#" + INPUT_CLIENT).val(doc);
    $("input[name='" + INPUT_CLIENT +"']").val(id);
    $(".modal-select-client").find(".cerrarModal").click();
}


