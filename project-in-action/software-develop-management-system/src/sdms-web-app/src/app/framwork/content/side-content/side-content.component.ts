import { Component, Input, OnInit } from '@angular/core';
import { ViewConfigularService } from 'src/app/framwork/service/view-configular/view-configular.service';

@Component({
  selector: 'app-side-content',
  templateUrl: './side-content.component.html',
  styleUrls: ['./side-content.component.css']
})

export class SideContentComponent implements OnInit {

  constructor(public view: ViewConfigularService) { }

  ngOnInit(): void {
  }

}
