import { Component, OnInit } from '@angular/core';
import { ViewConfigularService } from 'src/app/framwork/service/view-configular/view-configular.service';

@Component({
  selector: 'app-auth',
  templateUrl: './auth.component.html',
  styleUrls: ['./auth.component.css']
})
export class AuthComponent implements OnInit {

  constructor(public view:ViewConfigularService ) { }

  ngOnInit(): void {
    this.view.status.set('login_status', {
      id: -1,
      icon: '',
      content: '游客 ',
      level: 0,
    });
  }

}
