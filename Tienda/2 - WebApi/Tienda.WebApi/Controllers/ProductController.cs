using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using Tienda.Interfaces;
using Tienda.WebApi.Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Tienda.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [EnableCors]
    public class ProductController : ControllerBase
    {
        private readonly IProductLogic _productLogic;

        public ProductController(IProductLogic productLogic)
        {
            _productLogic = productLogic;
        }

        // GET: api/<Product>
        [HttpGet]
        [EnableCors]
        public ActionResult<IEnumerable<ProductForList>> Get([FromQuery]ProductFilter priceFilter)
        {
            var products = _productLogic.ListProducts().Where(t => t.Price > priceFilter.Price).Select(c => new ProductForList(c.Id, c.Name, c.Description, c.Price));
            return Ok(products);
        }

        // GET api/<Product>/5
        [HttpGet("{id}")]
        public ActionResult<ProductForList> Get(int id)
        {
            var product = _productLogic.GetProduct(id);
            if (product == null)
                return NotFound();

            return Ok(new ProductForList(product.Id, product.Name, product.Description, product.Price));


        }

        // POST api/<Product>
        [HttpPost]
        public ActionResult<int> Post([FromBody] ProductBase product)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var newProduct = _productLogic.CreateProduct(new Dtos.Product
            {
                Name = product.Name,
                Description = product.Description,
                Price = product.Price.Value
            });
            return (Ok(newProduct.Id));
        }

        // PUT api/<Product>/5
        [HttpPut("{id}")]
        public ActionResult Put(int id, [FromBody] ProductBase product)
        {
            _productLogic.UpdateProduct(new Dtos.Product
            {
                Id = id,
                Description = product.Description,
                Name = product.Name,
                Price = product.Price.Value
            });
            return Ok();
        }

        // DELETE api/<Product>/5
        [HttpDelete("{id}")]
        public ActionResult  Delete(int id)
        {
            var borrado = _productLogic.DeleteProduct(id);
            if (!borrado)
                return NotFound();
            return Ok();
        }
    }
}
