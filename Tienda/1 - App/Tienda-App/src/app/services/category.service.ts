import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Category } from '../Interfaces/category';

@Injectable({
  providedIn: 'root'
})
export class CategoryService {
  private myAppUrl = 'https://localhost:44350/';
  private myApiUrl = 'api/Category/';

  constructor(private http:HttpClient) { }

  getCategories(): Observable<Category[]> {
    return this.http.get<Category[]>(this.myAppUrl + this.myApiUrl);
  }

}
