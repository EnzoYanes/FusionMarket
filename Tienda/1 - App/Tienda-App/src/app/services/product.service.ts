import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Product } from '../Interfaces/product';

@Injectable({
  providedIn: 'root'
})
export class ProductService {
  private myAppUrl = 'https://localhost:44350/';
  private myApiUrl = 'api/product/';

  constructor(private http: HttpClient) { }

  getProducts(pageSize:string, name: string, categoryId: string): Observable<Product[]> {
    return this.http.get<Product[]>(this.myAppUrl + this.myApiUrl + 'GetProductsPaginated?pageIndex=1&pageSize='+pageSize+'&name='+name+'&categoryId='+categoryId+'&orderByNameOrPrice=name&ascOrDesc=asc');
  }
}