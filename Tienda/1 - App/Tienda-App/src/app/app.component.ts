import { Component } from '@angular/core';
import { select, Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { Product } from './Interfaces/product';
import { OrderLineState } from './store/reducer/order-line.reducer';
import { selectOrderLines } from './store/selector/order-line.selectors';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'Tienda-App';
  orderLines$: Observable<Product[]>;

  constructor(private store: Store<OrderLineState>){
    this.orderLines$ = this.store.pipe(select(selectOrderLines));
  }
}
