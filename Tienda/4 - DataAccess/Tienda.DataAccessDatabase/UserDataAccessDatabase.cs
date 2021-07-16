using Dapper;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tienda.Dto;
using Tienda.Interfaces;

namespace Tienda.DataAccessDatabase
{
    public class UserDataAccessDatabase : IUserPersistence
    {
        private String connectionString;

        public UserDataAccessDatabase(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public List<User> GetUsers()
        {
            var queryString = @"SELECT [Id], [Name], [Surname], [DocumentNumber], [CreatedDate], [Username], [Password], [StatusId]
                                FROM [dbo].[Users]";
            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                return connection.Query<User>(queryString).AsList();
            }
        }

        public User GetUser(string username)
        {
            var queryString = @"SELECT [Id], [Name], [Surname], [DocumentNumber], [CreatedDate], [Username], [Password], [StatusId]
                                FROM [dbo].[Users]
                                WHERE [Username] = @Username";
            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                return connection.QueryFirstOrDefault<User>(queryString, new { Username = username });
            }
        }

        public bool CreateUser(string name, string surname, string documentNumber, string username, string password)
        {
            if (GetUser(username) != null)
                return false;

            var queryString = @"INSERT INTO Users ([name], [Surname], [DocumentNumber], [CreatedDate], [Username], [Password], [StatusId])
                                VALUES (@Name, @Surname, @DocumentNumber, @CreatedDate, @Username, @Password, @StatusId)";
            User user = new User()
            {
                Name = name,
                Surname = surname,
                DocumentNumber = documentNumber,
                CreatedDate = DateTime.Now,
                Username = username,
                Password = password,
                StatusId = 1
            };
            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                connection.Execute(queryString, user);
                return true;
            }

            throw new NotImplementedException();
        }

    }
}
