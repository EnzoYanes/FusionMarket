using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tienda.Dto;

namespace Tienda.Interfaces
{
    public interface IUserPersistence
    {
        List<User> GetUsers();
        User GetUser(string username);
        bool CreateUser(string name, string surname, string documentNumber, string username, string password);
    }
}
