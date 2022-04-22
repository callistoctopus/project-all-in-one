import { HostListener } from '@angular/core';
import Proton from 'proton-engine';
import RAFManager from 'raf-manager';
import Stats from 'stats.js';
import { B } from './b';

window.onresize = function (e) {
  B1.canvas.width = window.innerWidth;
  B1.canvas.height = window.innerHeight;
};

export class B1 extends B {
  stats;
  proton;
  renderer;
  static emitter = [];

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

    for (let i = 0; i < 16; i++) {
      B1.emitter[i] = new Proton.Emitter();

      B1.emitter[i].rate = new Proton.Rate(
        new Proton.Span(2, 30),
        new Proton.Span(0.4, 0.2)
      );

      B1.emitter[i].addInitialize(new Proton.Mass(5));
      B1.emitter[i].addInitialize(new Proton.Radius(1, 1));
      B1.emitter[i].addInitialize(new Proton.Life(2, 10));
      B1.emitter[i].addInitialize(
        new Proton.Velocity(
          new Proton.Span(1, 2),
          new Proton.Span(20, 20),
          'polar'
        )
      );
      B1.emitter[i].addBehaviour(new Proton.RandomDrift(30, 30, 0.05));
      B1.emitter[i].addBehaviour(
        new Proton.Color('ff0000', 'random', Infinity, Proton.easeOutQuart)
      );
      B1.emitter[i].addBehaviour(new Proton.Scale(1, 1));
      B1.emitter[i].p.x = B1.canvas.width / 16 * (i + 1);
      B1.emitter[i].p.y = B1.canvas.height;
      B1.emitter[i].emit();

      this.proton.addEmitter(B1.emitter[i]);
    }


    this.renderer = new Proton.CanvasRenderer(B1.canvas);
    this.renderer.onProtonUpdate = () => {
      this.context.fillStyle = 'rgba(0, 0, 0, 0.1)';
      this.context.fillRect(0, 0, B1.canvas.width, B1.canvas.height);
    };
    this.proton.addRenderer(this.renderer);
  }

  render() {
    RAFManager.add(() => {
      for (let i = 0; i < 16; i++) {
        B1.emitter[i].rotation = i % 2 == 0 ? 110 : -70 ;
      }
      this.proton.update();
    });
  }
}
