using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Tienda.WebApi.Models
{
    public class Order
    {
        public int Id { get; set; }
        public string BillingNumber { get; set; }
        public DateTime CreatedDate { get; set; }
        public int UserId { get; set; }
        public int StatusId { get; set; }
    }
    public class OrderForList
    {
        public string BillingNumber { get; set; }
        public string Name { get; set; }
        public string Status { get; set; }
        public DateTime CreatedDate { get; set; }
        public decimal TotalPrice { get; set; }
    }

    public class OrderForAdmin
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int StatusId { get; set; }
        public string Status { get; set; }
        public DateTime CreatedDate { get; set; }
        public decimal TotalPrice { get; set; }
    }
}
