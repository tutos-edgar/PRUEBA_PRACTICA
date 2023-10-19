using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Prueba_login_pro
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
            if(Membership.ValidateUser(TextBox1.Text, TextBox2.Text))
            {
                Label3.Text = "LOS DATOS ESTAN VACIOS";
            }
            else
            {
                Label3.Text = "VERIFICAR ACCESO";
            }
        }

    }
}