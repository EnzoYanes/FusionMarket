import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {

  userForm = this.fb.group({
    name: ['', Validators.required],
    surname: ['', Validators.required],
    documentNumber: ['', Validators.required],
    username: ['', [Validators.required, Validators.email]],
    password: ['', Validators.required]
  });

  constructor(private fb: FormBuilder,
    private _userService: UserService,
    private route: Router) { }

  ngOnInit() {
  }

  onSubmit(){
    if (this.userForm.valid) {
      this._userService.addUser(this.userForm.value).then(x => this.route.navigate(["/products"]));
    }
  }

}
