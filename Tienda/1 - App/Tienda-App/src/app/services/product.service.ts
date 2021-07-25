import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Product, ProductsPaginated } from '../Interfaces/product';

@Injectable({
  providedIn: 'root'
})
export class ProductService {
  private myAppUrl = 'https://localhost:44350/';
  private myApiUrl = 'api/product/';

  constructor(private http: HttpClient) { }

  getProducts(pageIndex:number, pageSize:number, name: string, categoryId: string, orderBy:string, ascORdesc:string): Observable<ProductsPaginated> {
    return this.http.get<ProductsPaginated>(this.myAppUrl + this.myApiUrl + 'GetProductsPaginated?pageIndex='+(pageIndex + 1)+'&pageSize='+pageSize+'&name='+name+'&categoryId='+categoryId+'&orderByNameOrPrice='+orderBy+'&ascOrDesc='+ascORdesc);
  }
}