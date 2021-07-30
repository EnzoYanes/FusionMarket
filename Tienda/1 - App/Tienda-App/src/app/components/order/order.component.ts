import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { select, Store } from '@ngrx/store';
import { async, Observable } from 'rxjs';
import { map } from "rxjs/operators";
import { Product } from 'src/app/Interfaces/product';
import { OrderService } from 'src/app/services/order.service';
import { removeOrderLine, resetOrderList } from 'src/app/store/action/order-line.actions';
import { OrderLineState } from 'src/app/store/reducer/order-line.reducer';
import { selectOrderLines } from 'src/app/store/selector/order-line.selectors';

@Component({
  selector: 'app-order',
  templateUrl: './order.component.html',
  styleUrls: ['./order.component.scss']
})
export class OrderComponent implements OnInit {

  orderLines$: Observable<Product[]>;
  total$: Observable<number>;
  myProducts: Product[] = [];
  displayedColumns: string[] = ['name','price','itemNumbers','subTotal','delete'];

  constructor(private store: Store<OrderLineState>, private route: Router, private _orderService: OrderService) {
    this.orderLines$ = this.store.pipe(select(selectOrderLines));
    this.total$ = this.orderLines$.pipe(map(order => order.reduce((total, item) => total + (item.price * item.itemNumbers), 0)));
  }

  ngOnInit() {
    this.orderLines$.subscribe(data => this.myProducts = data);
  }

  btn_RemoveItem(productId: number){
    if (confirm("¿Seguro que desea borrar el producto del carrito?")) {
      this.store.dispatch(removeOrderLine({productId}));
    }
  }

  buyOrder(){
    if (confirm("¿Seguro que desea comprar los productos del carrito?")) {
      let result = this._orderService.CreateOrder(this.myProducts);
      this.store.dispatch(resetOrderList());
      this.route.navigate(["/products"]);
    }
  }

}
