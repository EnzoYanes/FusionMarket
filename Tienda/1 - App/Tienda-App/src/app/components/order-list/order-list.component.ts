import { Component, OnInit } from '@angular/core';
import { OrderForList } from 'src/app/Interfaces/Order';
import { OrderService } from 'src/app/services/order.service';

@Component({
  selector: 'app-order-list',
  templateUrl: './order-list.component.html',
  styleUrls: ['./order-list.component.scss']
})
export class OrderListComponent implements OnInit {

  orders: OrderForList[] = [];
  displayedColumns: string[] = ['BillingNumber','Name','Status','CreatedDate','TotalPrice'];

  constructor(private _orderService: OrderService) { }

  ngOnInit() {
    this.getOrders();
  }

  getOrders(): void {
    this._orderService.GetOrdersToUser().subscribe(data => this.orders = data);
  }


  /* getProducts(pageIndex:number, pageSize:number, name: string, categoryId: string, orderBy:string, ascORdesc:string): void {
    this._productService.getProducts(pageIndex, pageSize, name, categoryId, orderBy, ascORdesc).subscribe(data => {
      this.products = data.products;
      this.length = data.totalRow;
    });
  } */

}
