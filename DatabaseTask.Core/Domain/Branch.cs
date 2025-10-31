using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseTask.Core.Domain
{
    public class Branch
    {
        [Key]
        public Guid BranchID { get; set; } = Guid.NewGuid();
        public string Name { get; set; } = string.Empty;
        public int PhoneNumber { get; set; }
        [ForeignKey("BranchID")]
        public ICollection<Employee> Employees { get; set; }
    }
}
