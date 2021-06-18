using System;
using System.Linq;
using System.Collections.Generic;
using Dtos;
using Tienda.Interfaces;

namespace Tienda.DataAccess
{
    public class ProductDataAccess : IProductPersistence
    {
        private int NextId = 1;
        private List<Product>  Products { get; }

        public ProductDataAccess()
        {
            Products = new List<Product>();
        }

        public int CreateProduct(Product product)
        {
            product.Id = NextId++;
            this.Products.Add(product);
            return product.Id;
        }
        
        public bool DeleteProduct(int id)
        {
            var product = GetProduct(id);
            return Products.Remove(product);
        }

        public void UpdateProduct(Product newProductData)
        {
            var currentProduct = GetProduct(newProductData.Id);
            if (currentProduct == null)
            {
                throw new Exception("Producto encontrado");
            }

            currentProduct.Name = newProductData.Name;
            currentProduct.Description = newProductData.Description;
            currentProduct.Price = newProductData.Price;
        }

        public List<Product> ListProducts()
        {
            return this.Products.Select(p => new Product
            {
                Id = p.Id,
                Name = p.Name,
                Description = p.Description,
                Price = p.Price
            }).ToList();
            
    }

        public Product GetProduct(int id)
        {
            return Products.FirstOrDefault(p => p.Id == id);
        }
    }




















// var productos = new List<ProductoListDto>();
            // foreach (var p in this.Productos)
            // {
            //     var producto = new ProductoListDto
            //     {
            //         Id = p.Id,
            //         Nombre = p.Nombre,
            //         Descripcion = p.Descripcion,
            //         Precio = p.Precio
            //     };
            //     productos.Add(producto);
            // }
            // return productos;
        }