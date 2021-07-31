using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Tienda.Interfaces;
using Tienda.WebApi.Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Tienda.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly IOrderPersistence _orderPersistence;

        public OrderController(IOrderPersistence orderPersistence)
        {
            _orderPersistence = orderPersistence;
        }

        // GET: api/<OrderController>
        [HttpGet]
        [Route("GetOrdersToAdmin")]
        public ActionResult<List<OrderForAdmin>> GetOrdersToAdmin()
        {
            var orders = _orderPersistence.GetOrdersToAdmin().Select(o => new OrderForAdmin
            {
                Id = o.Id,
                Name = o.Name,
                CreatedDate = o.CreatedDate,
                TotalPrice = o.TotalPrice,
                Status = o.Status,
                StatusId = o.StatusId
            }).ToList();

            return orders;
        }

        [HttpGet]
        [Route("GetOrdersToUser")]
        public ActionResult<List<OrderForList>> GetOrdersToUser()
        {
            var orders = _orderPersistence.GetOrdersToUser().Select(o => new OrderForList
            {
                BillingNumber = o.BillingNumber,
                Name = o.Name,
                Status = o.Status,
                CreatedDate = o.CreatedDate,
                TotalPrice = o.TotalPrice
            }).ToList();

            return orders;
        }

        // GET api/<OrderController>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<OrderController>
        [HttpPost]
        public ActionResult<int> Post([FromQuery] int userId)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            return _orderPersistence.CreateOrder(userId);
        }

        [HttpPost]
        [Route("OrderLines")]
        public ActionResult<bool> Post([FromBody] List<ProductInOrder> products)
        {
            var newProducts = products.Select(p => new Dtos.ProductInOrder 
            { 
                id = p.id,
                price = p.price,
                itemNumbers = p.itemNumbers
            }).ToList();

            return _orderPersistence.CreateOrderLines(newProducts, 0);
        }

        // PUT api/<OrderController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] int statusId)
        {
            _orderPersistence.SetOrderState(id, statusId);
        }

        // DELETE api/<OrderController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
