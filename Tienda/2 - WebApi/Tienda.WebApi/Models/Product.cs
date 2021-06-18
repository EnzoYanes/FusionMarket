
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Tienda.WebApi.Models
{
    public class ProductBase
    {
        [Required]
        public string Name { get; set; }
        public string Description { get; set; }
        [Required]
        public decimal? Price { get; set; }
    }

    public class ProductForList
    {
        public int Id { get; }
        public string Name { get; }
        public string Description { get; }
        public decimal Price { get; }

        public ProductForList(int id, string name, string description, decimal price)
        {
            Id = id;
            Name = name;
            Description = description;
            Price = price;
        }
    }
}
