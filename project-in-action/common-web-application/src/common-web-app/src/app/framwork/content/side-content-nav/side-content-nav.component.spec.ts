import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SideContentNavComponent } from './side-content-nav.component';

describe('SideContentNavComponent', () => {
  let component: SideContentNavComponent;
  let fixture: ComponentFixture<SideContentNavComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ SideContentNavComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(SideContentNavComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
