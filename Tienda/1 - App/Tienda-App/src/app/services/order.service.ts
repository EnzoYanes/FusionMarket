import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { OrderForList as OrderForList } from '../Interfaces/Order';
import { Product } from '../Interfaces/product';

@Injectable({
  providedIn: 'root'
})
export class OrderService {
  private myAppUrl = 'https://localhost:44350/api/order/';

  constructor(private http: HttpClient) { }

  GetOrdersToUser(): Observable<OrderForList[]> {
    return this.http.get<OrderForList[]>(this.myAppUrl + "GetOrdersToUser/");
  }

  CreateOrder(orderLines: Product[]): Promise<any>{
    return this.http.post(this.myAppUrl + "OrderLines/", orderLines).toPromise();
  }
}