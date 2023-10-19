using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using System.Xml.Linq;
using System.Windows.Forms;

namespace Prj_Capa_Datos
{
    public class Conexion_Prueba
    {

        public static string cadena = ConfigurationManager.ConnectionStrings["cadena_conexion"].ToString();
        SqlDataAdapter dt = new SqlDataAdapter();
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();

        public bool conectar()
        {
            using(SqlConnection cn = new SqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    //MessageBox.Show("conectado");
                    Console.WriteLine("Conectado");
                    cn.Close();
                    return true;
                }
                catch { return false; }
            }
        }

        public DataSet consulta(string tabla)
        {
            string sql = "SELECT * FROM " + tabla;
            using (SqlConnection cn = new SqlConnection(cadena))
            {
                try
                {
                    dt = new SqlDataAdapter(sql, cn);
                    ds = new DataSet();
                    dt.Fill(ds);
                    //MessageBox.Show(ds.Tables[0].Rows.Count.ToString());
                    return ds;
                }
                catch { return null; }
            }

        }

        public int Insertar(string documento, string nombre, string apellido, string telefono)
        {
            int afectados = 0;

            using (SqlConnection cn = new SqlConnection(cadena))
            {
                try
                {
                    string sql = "INSERT INTO persona (documento, nombre, apellido, telefono) VALUES(@documento, @nombre, @apellido, @telefono)";
                    cmd = new SqlCommand(sql, cn);
                    cmd.Parameters.AddWithValue("@documento", documento);
                    cmd.Parameters.AddWithValue("@nombre", nombre);
                    cmd.Parameters.AddWithValue("@apellido", apellido);
                    cmd.Parameters.AddWithValue("@telefono", telefono);

                    cn.Open();
                    afectados = Convert.ToInt32(cmd.ExecuteNonQuery());
                    cn.Close();
                    return afectados;
                }
                catch {
                    cn.Close();
                    return afectados; 
                }
            }

        }

        public int Actualizar(string documento, string nombre, string apellido, string telefono)
        {
            int afectados = 0;

            using (SqlConnection cn = new SqlConnection(cadena))
            {
                try
                {
                    string sql = "UPDATE persona SET  documento=@documento, nombre=@nombre, apellido=@apellido, telefono=@telefono WHERE documento=@documento";
                    cmd = new SqlCommand(sql, cn);
                    cmd.Parameters.AddWithValue("@documento", documento);
                    cmd.Parameters.AddWithValue("@nombre", nombre);
                    cmd.Parameters.AddWithValue("@apellido", apellido);
                    cmd.Parameters.AddWithValue("@telefono", telefono);
                    cn.Open();
                    afectados = Convert.ToInt32(cmd.ExecuteNonQuery());
                    cn.Close();
                    return afectados;
                }
                catch {
                    cn.Close();
                    return afectados; 
                }
            }

        }


        public int Eliminar(string id)
        {
            int afectados = 0;

            using (SqlConnection cn = new SqlConnection(cadena))
            {
                try
                {
                    string sql = "delete from persona where documento =  @documento";
                    cmd = new SqlCommand(sql, cn);
                    cmd.Parameters.AddWithValue("@documento", id);
                    cn.Open();
                    afectados = Convert.ToInt32(cmd.ExecuteNonQuery());
                    cn.Close();                   
                    return afectados;
                }
                catch {
                    cn.Close();
                    return afectados; 
                }
            }

        }

        public int DevolverFilas(string tabla)
        {
            int filas = 0;
            string sql = "select count(1) from " + tabla;
            using (SqlConnection cn = new SqlConnection(cadena))
            {
                try
                {
                    cmd = new SqlCommand(sql, cn);
                    cn.Open();
                    filas = Convert.ToInt32(cmd.ExecuteScalar());
                    cn.Close();
                    return filas;
                }
                catch { 
                    cn.Close();
                    return filas; 
                }
            }
        }


    }
}
