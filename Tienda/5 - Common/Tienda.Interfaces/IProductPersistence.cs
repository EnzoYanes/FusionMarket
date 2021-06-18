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

        int CreateProduct(Product product);

        List<Product> ListProducts();

        bool DeleteProduct(int id);

        void UpdateProduct(Product newProductData);
    }
}
