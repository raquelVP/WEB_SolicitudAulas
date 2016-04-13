<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="webSolicitudAulas.Login" %>

<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6 lt8"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7 lt8"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8 lt8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href='https://fonts.googleapis.com/css?family=Lobster' rel='stylesheet' type='text/css' />
    <link href="Content/Formularios/Login.css" rel="stylesheet" />
    <link href="Content/Custom/animate-custom.css" rel="stylesheet" />
    <title>Inicio Sesion</title>
</head>
<body>
    <a class="hiddenanchor" id="toregister"></a>
    <a class="hiddenanchor" id="tologin"></a>
    <div id="wrapper">
        <div id="login" class="animate">
            <form id="frmLogin" action="" autocomplete="on">
                <h1>Login</h1>
                <label for="username" data-icon="u">email</label>
                <input id="username" name="username" required="required" type="text" maxlength="20" placeholder="Ingrese su usuario o correo" />

                <label for="password" data-icon="p">pass</label>
                <input id="password" name="password" required="required" type="password" maxlength="20" placeholder="Ingrese su contraseña" />

                <button type="submit">Log In</button>
                <p class="change_link">
                    Not a member yet ?<a href="#toregister" class="to_register"> Join us </a>
                </p>
            </form>
        </div>
        <div id="register" class="animate">
            <form id="frmRegistro" action="" autocomplete="on">
                <h1>Sign up</h1>
                <label for="usernameReg" data-icon="u">Your username</label>
                <input id="usernameReg" name="usernameReg" required="required" type="text" maxlength="20" placeholder="username" />

                <label for="emailReg" data-icon="e">Your email</label>
                <input id="emailReg" name="emailReg" required="required" type="text" maxlength="20" placeholder="e-mail" />

                <label for="passwordReg" data-icon="p">Your password</label>
                <input id="passwordReg" name="passwordReg" required="required" type="text" maxlength="20" placeholder="password" />

                <label for="passwordConReg" data-icon="p">Confirm your password</label>
                <input id="passwordConReg" name="passwordConReg" required="required" type="text" maxlength="20" placeholder="confirm your password" />

                <button type="submit">Sign up</button>
                <p class="change_link">
                    Already a member ?<a href="#tologin" class="to_register"> Go and log in </a>
                </p>
            </form>
        </div>
    </div>
</body>
</html>
