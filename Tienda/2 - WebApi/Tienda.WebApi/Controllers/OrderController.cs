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
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
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
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<OrderController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
