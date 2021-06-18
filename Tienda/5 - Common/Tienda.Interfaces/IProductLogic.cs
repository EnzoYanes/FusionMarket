using Dtos;
using System.Collections.Generic;

namespace Tienda.Interfaces
{
    public interface IProductLogic
    {
        Product GetProduct(int id);

        Product CreateProduct(Product product);

        List<Product> ListProducts();
        
        bool DeleteProduct(int id);

        void UpdateProduct(Product newProductData);
    }

}