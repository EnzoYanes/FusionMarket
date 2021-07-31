import { Component, OnInit } from '@angular/core';
import { Order } from 'src/app/Interface/order';
import { OrderService } from 'src/app/Services/order.service';

@Component({
  selector: 'app-orders',
  templateUrl: './orders.component.html',
  styleUrls: ['./orders.component.scss']
})
export class OrdersComponent implements OnInit {

  orders: Order[] = [];
  columnsToDisplay = ['id', 'name', 'createdDate', 'status', 'totalPrice', 'action'];

  constructor(private _orderService: OrderService) { }

  ngOnInit(): void {
    this.getOrders();
  }

  getOrders(): void{
    this._orderService.getOrders().subscribe(data => this.orders = data);
  }

  setOrderState(orderId: number, statusId: number): void{
    if (confirm("¿Está seguro de cambiar el estado de la orden?")) {
      this._orderService.setOrderState(orderId, statusId).then(x => window.location.reload());
    }
  }

}
