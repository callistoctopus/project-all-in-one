import { HostListener } from '@angular/core';
import Proton from 'proton-engine';
import RAFManager from 'raf-manager';
import Stats from 'stats.js';

window.onresize = function (e) {
  B.canvas.width = window.innerWidth;
  B.canvas.height = window.innerHeight;
};

export class B {
    static canvas;
    context;
    id:string = '';
  
    constructor(id) {
      this.id = id;
    }

    init(): void {
      this.init2();
    }

    destroy(){
      
    }

    init2(){}
  
    initCanvas() {
      B.canvas = document.getElementById('canvas');
      B.canvas.width = window.innerWidth;
      B.canvas.height = window.innerHeight;
      this.context = B.canvas.getContext('2d');
      this.context.height=this.context.height;
      this.context.clearRect(0,0,this.context.width,this.context.height);
    }

}
