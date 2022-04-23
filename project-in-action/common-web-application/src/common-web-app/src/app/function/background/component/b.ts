export abstract class B {
  id: string = '';

  constructor(id) {
    this.id = id;
  }

  abstract init();

  abstract destory();
}
