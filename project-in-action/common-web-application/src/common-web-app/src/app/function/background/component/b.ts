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
  
    constructor() {
    this.init();
    }

    init(): void {
      this.initCanvas();
    }
  
    initCanvas() {
      B.canvas = document.getElementById('canvas');
      B.canvas.width = window.innerWidth;
      B.canvas.height = window.innerHeight;
      this.context = B.canvas.getContext('2d');
    }

}
