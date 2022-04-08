import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ViewConfigularService {

  public showFiller: boolean = false;

  clickCount = 0;

  functions: string[] = [];
  current_function = '';

  functionMap = new Map();

  subfuncMap = new Map();

  subfuncs: string[] = [];
  current_subfunc = '';

  statusMap = new Map();

  constructor(private router: Router) {
  }

  sideOnClick(func:string){
    if (this.current_function == func) {
      this.showFiller =
        !this.showFiller && this.subfuncs != null && this.subfuncs.length > 0;
    } else {
      this.current_function = func;
      this.subfuncs = this.subfuncMap.get(this.current_function);
      this.showFiller =
        this.subfuncs != null && this.subfuncs.length > 0;
    }

    if (this.subfuncs == null || this.subfuncs.length <= 0) {
      this.router.navigateByUrl(this.functionMap.get(func));
    }
  }
}
