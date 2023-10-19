<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Prueba_login_pro.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <div class="container">
        <form id="form1" runat="server">
            <div class="group-form">
                <asp:Label ID="Label1" runat="server" Text="Usuario"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>                
            </div>
            <div class="group-form">
                <asp:Label ID="Label2" runat="server" Text="Password"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            </div>
            <div class="group-form">
                <asp:Button ID="Button1" runat="server" Text="Button" />
            </div>
             <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
        </form>
    </div>
</body>
</html>
