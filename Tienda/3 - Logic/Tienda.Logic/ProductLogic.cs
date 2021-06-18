using Dtos;
using System.Collections.Generic;
using Tienda.Interfaces;

namespace Tienda.Logic
{
    public class ProductLogic : IProductLogic
    {
        public IProductPersistence  dataAccess { get; }

        public ProductLogic(IProductPersistence productPersistence)
        {
            this.dataAccess = productPersistence;
        }

        public Product CreateProduct(Product product)
        {
            product.Id = this.dataAccess.CreateProduct(product);
            return product;
        }
        
        public List<Product> ListProducts()
        {
            return this.dataAccess.ListProducts();
        }
        
        public bool DeleteProduct(int id)
        {
            if(dataAccess.GetProduct(id) != null)
            {
                return dataAccess.DeleteProduct(id);
            }
            return false;
        }

        public void UpdateProduct(Product newProductData)
        {
            dataAccess.UpdateProduct(newProductData);
        }

        public Product GetProduct(int id)
        {
            return dataAccess.GetProduct(id);
        }
    }
}
