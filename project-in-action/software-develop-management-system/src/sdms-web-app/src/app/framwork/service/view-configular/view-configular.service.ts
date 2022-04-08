import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ViewConfigularService {

  log = '';

  public showFiller: boolean = false;

  functions: string[] = [];
  current_function = '';

  subfuncs = new Map();
  funcs: string[] = [];
  current_func = '';

  // subfuncs = ['function1', 'function2'];

  constructor() {
  }
}
