using DatabaseTask.Core.Domain;
using DatabaseTask.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace DatabaseTask.Controllers
{
    public class EmployeeController : Controller
    {
        public DatabaseTaskDbContext _context;
        public IConfiguration _config;

        public EmployeeController(DatabaseTaskDbContext context, IConfiguration config)
        {
            _context = context;
            _config = config;
        }

        public JsonResult Index()
        {
            string connectionString = _config.GetConnectionString("DefaultConnection");

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "dbo.spSearchEmployeesGoodDynamicSQL";
                cmd.CommandType = System.Data.CommandType.Text;
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                List<Employee> model = new List<Employee>();
                while (sdr.Read())
                {
                    var details = new Employee();
                    details.FirstName = sdr["FirstName"].ToString();
                    details.LastName = sdr["LastName"].ToString();
                    details.DepartmentName = sdr["DepartmentName"].ToString();
                    details.Salary =  Convert.ToInt32(sdr["Salary"]);
                    details.FirstName = sdr["FirstName"].ToString();
                    model.Add(details);

                }
                return new JsonResult(model);
            }
        }

    }
}
