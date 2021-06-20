using Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tienda.Interfaces
{
    public interface IProductPersistence
    {
        Product GetProduct(int id);

        List<Product> GetProductsPaginated(int pageIndex, int pageSize, string name, int categoryId, string OrderByNameOrPrice, string AscOrDesc);

        int CreateProduct(Product product);

        List<Product> ListProducts();

        bool DeleteProduct(int id);

        void UpdateProduct(Product newProductData);
    }
}
