using Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tienda.Dto;

namespace Tienda.Interfaces
{
    public interface IOrderPersistence
    {
        List<OrderForList> GetOrdersToUser();
        List<OrderForAdmin> GetOrdersToAdmin();
        int CreateOrder(int userId);
        bool CreateOrderLines(List<ProductInOrder> products, int userId);
        void SetOrderState(int orderId, int statusId);
    }
}
