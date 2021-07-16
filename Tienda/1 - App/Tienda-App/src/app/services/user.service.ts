import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { User } from '../Interfaces/user';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private myAppUrl = 'https://localhost:44350/';
  private myApiUrl = 'api/User/';

  constructor(private http: HttpClient) { }

  addUser(user: User): Promise<any>{
    return this.http.post(this.myAppUrl + this.myApiUrl, user).toPromise();
  }

}
