using Dapper;
using Dtos;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Threading;
using Tienda.Interfaces;

namespace Tienda.DataAccessDatabase
{
    public class ProductDataAccessDatabase : IProductPersistence
    {
        private String connectionString;


        public ProductDataAccessDatabase(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public int CreateProduct(Product product)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                var queryString = @"insert into Products([Name], [Description], Price)
                                    output inserted.Id
                                    values (@Name, @Description, @Price)";
                connection.Open();

                var id = 0;

                using (var command = connection.CreateCommand())
                {
                    command.CommandType = System.Data.CommandType.Text;
                    command.CommandText = queryString;
                    command.Parameters.AddWithValue("Name", product.Name);
                    command.Parameters.AddWithValue("Description", product.Description);
                    var priceParameter = command.CreateParameter();
                    priceParameter.ParameterName = "Price";
                    priceParameter.SqlDbType = System.Data.SqlDbType.Decimal;
                    priceParameter.Value = product.Price;
                    command.Parameters.Add(priceParameter);
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            id = (int)reader["Id"];
                        }

                    }
                }

                return id;
                // var cantidadDeFilasAfectadas = connection.Execute(queryString, product);

                //using (var command = connection.CreateCommand())
                //{


                //    //command.CommandType = System.Data.CommandType.Text;
                //    //command.CommandText = queryString;
                //    //command.Parameters.AddWithValue("Id", product.Id);
                //    //command.Parameters.AddWithValue("Name", product.Name);
                //    //command.Parameters.AddWithValue("Description", product.Description);
                //    //var priceParameter = command.CreateParameter();
                //    //priceParameter.ParameterName = "Price";
                //    //priceParameter.SqlDbType = System.Data.SqlDbType.Decimal;
                //    //priceParameter.Value = product.Price;
                //    //command.Parameters.Add(priceParameter);
                //    //var cantidadDeFilasAfectadas = command.ExecuteNonQuery();
                //    //command.Parameters.AddWithValue("Price", product.Price);
                //}
            }
        }

        public bool DeleteProduct(int id)
        {
            var queryString = @"delete p
                                  
                                  FROM [dbo].[Products] p
                                  WHERE p.Id = @Id";
            using (var connection = new SqlConnection(connectionString))
            {

                connection.Open();
                connection.Execute(queryString, new { Id = id });
                return true;
            }
        }

        public Product GetProduct(int id)
        {
            var queryString = @"SELECT [Id]
                                      ,[Name]
                                      ,[Description]
                                      ,[Price]
                                  FROM [dbo].[Products]
                            where Id = @Id";
            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                return connection.QueryFirstOrDefault<Product>(queryString, new { Id = id });
            }
        }

        public List<Product> ListProducts()
        {
            List<Product> products;
            using (var connection = new SqlConnection(connectionString))
            {
                var queryString = @"SELECT [Id]
                                      ,[Name]
                                      ,[Description]
                                      ,[Price]
                                  FROM [dbo].[Products]";
                connection.Open();

                //List<Product> products = new List<Product>();

                //using (var command = connection.CreateCommand())
                //{
                //    command.CommandType = System.Data.CommandType.Text;
                //    command.CommandText = queryString;
                //    using (var reader = command.ExecuteReader())
                //    {
                //        while (reader.Read())
                //        {
                //            var id = (int)reader["Id"];
                //            var name = reader.GetString(1);
                //            var description = (string)reader["Description"];
                //            var price = reader.GetDecimal(3);
                //            var product = new Product
                //            {
                //                Id = id,
                //                Name = name,
                //                Description = description,
                //                Price = price
                //            };
                //            products.Add(product);
                //        }
                //    }

                //}

                //return products;

                products = connection.Query<Product>(queryString).AsList();
            }

            return products;
        }

        public void UpdateProduct(Product newProductData)
        {
            var queryString = @"Update p
                                    set
                                      p.[Name] = @Name
                                      ,[Description] = @Description
                                      ,[Price] = @Price
                                  FROM [dbo].[Products] p
                                  WHERE p.Id = @Id";
            using (var connection = new SqlConnection(connectionString))
            {
         
                connection.Open();
                connection.Execute(queryString, newProductData);

            }
        }
    }
}
