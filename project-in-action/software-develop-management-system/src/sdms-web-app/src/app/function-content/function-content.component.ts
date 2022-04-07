import { Component, OnInit } from '@angular/core';
import { ViewConfigularService } from 'src/app/framwork/service/view-configular/view-configular.service';

@Component({
  selector: 'app-function-content',
  templateUrl: './function-content.component.html',
  styleUrls: ['./function-content.component.css'],
})
export class FunctionContentComponent implements OnInit {
  constructor(public view: ViewConfigularService) {}

  ngOnInit(): void {}
}
