using Dapper;
using Dtos;
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
    public class OrderDataAccessDataBase : IOrderPersistence
    {
        private String connectionString;

        public OrderDataAccessDataBase(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public int CreateOrder(int userId)
        {
            var queryString = @"INSERT INTO [dbo].[Orders]([BillingNumber],[CreatedDate],[UserId],[StatusId]) 
                                OUTPUT inserted.Id 
                                VALUES (@BillingNumber,@CreatedDate,@UserId,@StatusId)";

            using (var connection = new SqlConnection(connectionString))
            {
                int newId = connection.Query<int>(queryString, new { 
                    BillingNumber = $"{userId}-{DateTime.Now.Millisecond}",
                    CreatedDate = DateTime.Now,
                    UserId = userId,
                    StatusId = 1}).FirstOrDefault();
                return newId;
            }
        }

        public bool CreateOrderLines(List<ProductInOrder> products, int userId)
        {
            try
            {
                using (var connection = new SqlConnection(connectionString))
                {
                    if (userId == 0) // Esto es por no manejar Login
                    {
                        var queryRandomUserId = @"SELECT TOP 1 ID FROM Users ORDER BY NEWID()";
                        userId = connection.Query<int>(queryRandomUserId).FirstOrDefault();
                    }
                    int orderId = CreateOrder(userId);

                    var queryString = @"INSERT INTO [dbo].[OrderLines] ([OrderId],[ProductId],[Quantity],[UnitPrice])
                                VALUES (@OrderId,@ProductId,@Quantity,@UnitPrice)";

                    foreach (ProductInOrder item in products)
                    {
                        var param = new
                        {
                            OrderId = orderId,
                            ProductId = item.id,
                            Quantity = item.itemNumbers,
                            UnitPrice = item.price
                        };
                        connection.Execute(queryString, param);
                    }
                }

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public List<OrderForList> GetOrdersToUser()
        {
            var queryString = @"SELECT o.BillingNumber, u.Name, os.Description as Status, o.CreatedDate, SUM(ol.Subtotal) as TotalPrice
                                FROM Orders o
                                INNER JOIN Users u ON u.Id = o.UserId
                                INNER JOIN OrderStatus os ON os.OrderStatusId = o.StatusId
                                INNER JOIN OrderLines ol ON ol.OrderId = o.Id
                                GROUP BY o.BillingNumber, u.Name, os.Description, o.CreatedDate
                                ORDER BY o.CreatedDate DESC";

            using (var connection = new SqlConnection(connectionString))
            {
                var orders = connection.Query<OrderForList>(queryString).AsList();
                return orders;
            }
        }
    }
}
