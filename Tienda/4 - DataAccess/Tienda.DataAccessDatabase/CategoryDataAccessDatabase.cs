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
    public class CategoryDataAccessDatabase : ICategoryPersistence
    {
        private String connectionString;

        public CategoryDataAccessDatabase(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public List<Category> GetCategories()
        {
            var queryString = @"SELECT Id, Description FROM Categories";
            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                return connection.Query<Category>(queryString).AsList();
            }
        }
    }
}
