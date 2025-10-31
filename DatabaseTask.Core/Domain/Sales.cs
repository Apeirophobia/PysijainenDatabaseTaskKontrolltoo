using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseTask.Core.Domain
{
    public class Sales
    {
        [Key]
        public Guid SalesID { get; set; } = Guid.NewGuid();
        public DateTime Date { get; set; } = DateTime.Now;
        public int Total { get; set; }
        /*[ForeignKey("EmployeeID")]
        public ICollection<Employee> Employees { get; set; }
        [ForeignKey("CustomerID")]
        public ICollection<Customer> Customers { get; set; }    
        */
    }
}
