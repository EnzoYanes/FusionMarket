using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Tienda.WebApi.Models
{
    public class ProductFilter
    {
        [Required]
        public decimal? Price { get; set; }
    }
}
