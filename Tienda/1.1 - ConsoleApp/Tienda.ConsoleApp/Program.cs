using Dtos;
using System;
using System.Linq;
using Tienda.DataAccessDatabase;
using Tienda.Interfaces;
using Tienda.Logic;

namespace Tienda.ConsoleApp
{
    class Program
    {
        static void Main(string[] args)
        {
            var finalizar = false;
            var connectionString = "Server=DESKTOP-RCIFPVC\\SQLEXPRESS; Database=Tienda; User Id=labUser; Password=Password01.;";
            IProductLogic logic = new ProductLogic(new ProductDataAccessDatabase(connectionString));

            while (!finalizar)
            {
                Console.WriteLine(@"Las opciones disponibles son
                    1 listado de productos
                    2 alta de producto
                    3 eliminar producto
                    4 modificar producto
                    5 salir
                ");
                var entrada = Console.ReadLine();

                switch (entrada)
                {
                    case "1":
                        {
                            Console.WriteLine("listado");
                            var productos = logic.ListProducts();
                            if (!productos.Any())
                            {
                                Console.WriteLine("No hay productos");
                            }

                            foreach (var producto in productos)
                            {
                                Console.WriteLine($" id {producto.Id}, Nombre {producto.Name}, Descripcion {producto.Description}, Precio {producto.Price}");
                            }


                            break;
                        };
                    case "2":
                        {
                            Console.WriteLine("alta");

                            Console.WriteLine("Ingrese id");
                            if (!int.TryParse(Console.ReadLine(), out int id))
                            {
                                Console.WriteLine("Id incorrecto");
                                break;
                            }

                            var newProduct = RequestProductData(id);

                            if (newProduct != null)
                            {
                                try
                                {
                                    logic.CreateProduct(newProduct);
                                }
                                catch (Exception)
                                {
                                    Console.WriteLine("hubo un error al ingresar el producto");
                                }
                            }

                            break;
                        };
                    case "3":
                        {
                            Console.WriteLine("eliminar");

                            Console.WriteLine("Ingrese id");
                            if (!int.TryParse(Console.ReadLine(), out int id))
                            {
                                Console.WriteLine("Id incorrecto");
                                break;
                            }
                            try
                            {
                                var success = logic.DeleteProduct(id);
                                if (success)
                                {
                                    Console.WriteLine("Producto eliminado");
                                }
                                else
                                {
                                    Console.WriteLine("No se encontró el producto");
                                }
                            }
                            catch (Exception)
                            {
                                Console.WriteLine("hubo un error al eliminar el producto");
                            }
                            break;
                        };
                    case "4":
                        {
                            Console.WriteLine("modificar");

                            Console.WriteLine("Ingrese id a modificar");
                            if (!int.TryParse(Console.ReadLine(), out int id))
                            {
                                Console.WriteLine("Id incorrecto");
                                break;
                            }
                            try
                            {
                                var product = logic.GetProduct(id);
                                if (product == null)
                                {
                                    Console.WriteLine("El producto no existe");
                                    break;
                                }
                                else
                                {
                                    var newProductData = RequestProductData(id);
                                    if(newProductData != null)
                                    {
                                        newProductData.Id = id;
                                        logic.UpdateProduct(newProductData);
                                        Console.WriteLine("Producto actualizado");
                                    }
                                }
                                
                            }
                            catch (Exception)
                            {
                                Console.WriteLine("hubo un error al modificar el producto");
                            }
                            break;
                        };
                    case "5":
                        {
                            Console.WriteLine("salir");
                            finalizar = true;
                            break;
                        };
                    default:
                        {
                            Console.WriteLine("Opcion incorrecta");
                            break;
                        };
                }
            }
        }

        private static Product RequestProductData(int id)
        {
            var productData = new Product { Id = id};

            Console.WriteLine("Ingrese nombre");
            productData.Name = Console.ReadLine();
            
            Console.WriteLine("Ingrese Descripcion");
            productData.Description = Console.ReadLine();
            
            Console.WriteLine("Ingrese Precio");
            decimal price;
            if (!decimal.TryParse(Console.ReadLine(), out price))
            {
                Console.WriteLine("precio incorrecto");
                return null;
            }
            else
            {
                productData.Price = price;
            }

            return productData;
        }
    }
}
