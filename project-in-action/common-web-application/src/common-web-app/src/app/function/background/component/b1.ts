import { HostListener } from '@angular/core';
import Proton from 'proton-engine';
import RAFManager from 'raf-manager';
import Stats from 'stats.js';
import { B } from './b';

window.onresize = function (e) {
  B1.canvas.width = window.innerWidth;
  B1.canvas.height = window.innerHeight;
  B1.emitter.p.x = B1.canvas.width / 2;
  B1.emitter.p.y = B1.canvas.height / 2;
};

export class B1 extends B{
    stats;
    proton;
    renderer;
    static emitter;
  
    constructor() {
      super();
      this.initCanvas();
      this.createProton();
      this.render();
    }
  
    initStats() {
      this.stats = new Stats();
      this.stats.setMode(2);
      this.stats.domElement.style.position = 'absolute';
      this.stats.domElement.style.left = '80px';
      this.stats.domElement.style.top = '30px';
      document.body.appendChild(this.stats.domElement);
    }
  
    createProton() {
      this.proton = new Proton();
      B1.emitter = new Proton.Emitter();
      B1.emitter.rate = new Proton.Rate(
        new Proton.Span(10, 15),
        new Proton.Span(0.9, 0.8)
      );
  
      B1.emitter.addInitialize(new Proton.Mass(5));
      B1.emitter.addInitialize(new Proton.Radius(1, 1));
      B1.emitter.addInitialize(new Proton.Life(1, 10));
      B1.emitter.addInitialize(
        new Proton.Velocity(
          new Proton.Span(1, 2),
          new Proton.Span(-2, 2),
          'polar'
        )
      );
      B1.emitter.addBehaviour(new Proton.RandomDrift(30, 30, 0.05));
      B1.emitter.addBehaviour(
        new Proton.Color('ff0000', 'random', Infinity, Proton.easeOutQuart)
      );
      B1.emitter.addBehaviour(new Proton.Scale(1, 0.7));
      B1.emitter.p.x = B1.canvas.width / 2;
      B1.emitter.p.y = B1.canvas.height;
      B1.emitter.emit();
  
      this.proton.addEmitter(B1.emitter);
      this.renderer = new Proton.CanvasRenderer(B1.canvas);
      this.renderer.onProtonUpdate = () => {
        this.context.fillStyle = 'rgba(0, 0, 0, 0.1)';
        this.context.fillRect(0, 0, B1.canvas.width, B1.canvas.height);
      };
      this.proton.addRenderer(this.renderer);
    }
  
    render() {
      RAFManager.add(() => {
        B1.emitter.rotation += 1.5;
        this.proton.update();
      });
    }
}
