using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tienda.Dto;

namespace Tienda.Interfaces
{
    public interface ICategoryPersistence
    {
        List<Category> GetCategories();
    }
}
