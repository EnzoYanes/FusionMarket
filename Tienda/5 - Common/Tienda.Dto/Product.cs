using System;
using System.Collections.Generic;

namespace Dtos
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
    }

    public class ProductPaginated
    {
        public List<Product> products { get; set; }
        public int TotalRow { get; set; }
    }

    public class ProductInOrder
    {
        public int id { get; set; }
        public double price { get; set; }
        public int itemNumbers { get; set; }
    }
}
