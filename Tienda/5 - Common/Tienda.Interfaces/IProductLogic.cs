using Dtos;
using System.Collections.Generic;

namespace Tienda.Interfaces
{
    public interface IProductLogic
    {
        Product GetProduct(int id);

        List<Product> GetProductsPaginated(int pageIndex, int pageSize, string name, int categoryId, string OrderByNameOrPrice, string AscOrDesc);

        Product CreateProduct(Product product);

        List<Product> ListProducts();
        
        bool DeleteProduct(int id);

        void UpdateProduct(Product newProductData);
    }

}