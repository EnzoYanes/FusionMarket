import { Component, OnInit } from '@angular/core';
import { select, Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { Product } from 'src/app/Interfaces/product';
import { OrderLineState } from 'src/app/store/reducer/order-line.reducer';
import { selectOrderLines } from 'src/app/store/selector/order-line.selectors';

@Component({
  selector: 'app-order',
  templateUrl: './order.component.html',
  styleUrls: ['./order.component.scss']
})
export class OrderComponent implements OnInit {

  orderLines$: Observable<Product[]>;
  displayedColumns: string[] = ['name','price','itemNumbers','subTotal','delete'];

  constructor(private store: Store<OrderLineState>) {
    this.orderLines$ = this.store.pipe(select(selectOrderLines));
  }

  ngOnInit() {
  }

}
