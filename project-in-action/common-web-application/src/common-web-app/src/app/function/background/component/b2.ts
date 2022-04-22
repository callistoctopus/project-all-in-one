import Proton from 'proton-engine';
import RAFManager from 'raf-manager';
import Stats from 'stats.js';
import { B } from './b';

window.onresize = function (e) {
  B.canvas.width = window.innerWidth;
  B.canvas.height = window.innerHeight;
};

export class B2 extends B {
  stats;
  proton;
  renderer;
  emitter;
  pointZone;

  constructor() {
    super('b2');
  }
  
  override init2(){
    this.initCanvas();
    this.createProton();
    this.render();
  }

  // override destroy(): void {
  //   clearInterval(this.interval)
  // }

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

    this.emitter = new Proton.Emitter();
    this.emitter.rate = new Proton.Rate(
      new Proton.Span(Math.min(180, 180)),
      new Proton.Span(0.05, 0.2)
    );
    this.emitter.addInitialize(new Proton.Mass(1));
    this.emitter.addInitialize(new Proton.Radius(1, 4));
    this.emitter.addInitialize(new Proton.Life(Infinity));

    this.pointZone = new Proton.Position(
      new Proton.RectZone(0, 0, B2.canvas.width, B2.canvas.height)
    );
    this.emitter.addInitialize(this.pointZone);
    this.emitter.addInitialize(
      new Proton.Velocity(
        new Proton.Span(0.01, 0.05),
        new Proton.Span(0, 360),
        "polar"
      )
    );

    this.emitter.addBehaviour(new Proton.Alpha(Proton.getSpan(0.2, 0.9)));
    this.emitter.addBehaviour(new Proton.Color("#ffffff"));
    this.emitter.addBehaviour(
      new Proton.CrossZone(
        new Proton.RectZone(0, 0, B2.canvas.width, B2.canvas.height),
        "cross"
      )
    );

    this.emitter.emit("once");
    this.emitter.damping = 0;
    this.proton.addEmitter(this.emitter);

    this.renderer =  this.createRenderer(B.canvas);
    this.proton.addRenderer(this.renderer);
  }

  render() {
    RAFManager.add(() => {
      this.proton.update();
    });
  }

  createRenderer(canvas) {
    const R = 140;
    this.context = canvas.getContext("2d");
    this.renderer = new Proton.CanvasRenderer(canvas);

    this.renderer.onProtonUpdateAfter = () => {
      const particles = this.emitter.particles;
      for (let i = 0; i < particles.length; i++) {
        for (let j = i + 1; j < particles.length; j++) {
          const pA = particles[i];
          const pB = particles[j];
          const dis = pA.p.distanceTo(pB.p);

          if (dis < R) {
            const alpha = (1 - dis / R) * 0.5;
            this.context.strokeStyle = "rgba(255,255,255," + alpha + ")";
            this.context.beginPath();
            this.context.moveTo(pA.p.x, pA.p.y);
            this.context.lineTo(pB.p.x, pB.p.y);
            this.context.closePath();
            this.context.stroke();
          }
        }
      }
    };

    return this.renderer;
  }
}
