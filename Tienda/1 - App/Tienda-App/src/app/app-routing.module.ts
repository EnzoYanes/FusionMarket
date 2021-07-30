import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { OrderListComponent } from './components/order-list/order-list.component';
import { OrderComponent } from './components/order/order.component';
import { ProductListComponent } from './components/product-list/product-list.component';
import { RegisterComponent } from './components/register/register.component';

const routes: Routes = [
  {path: 'products', component: ProductListComponent},
  {path: 'register', component: RegisterComponent},
  {path: 'order', component: OrderComponent},
  {path: 'ordersToUser', component: OrderListComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
