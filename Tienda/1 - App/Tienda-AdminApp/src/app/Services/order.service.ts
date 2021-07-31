import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Order } from '../Interface/order';

@Injectable({
  providedIn: 'root'
})
export class OrderService {

  private myAppUrl = 'https://localhost:44350/api/order/';

  constructor(private http: HttpClient) { }

  getOrders(): Observable<Order[]>{
    return this.http.get<Order[]>(this.myAppUrl + "GetOrdersToAdmin/");
  }

  setOrderState(orderId:number, statusId:number): Promise<any>{
    return this.http.put(this.myAppUrl + orderId, statusId).toPromise();
  }
}
