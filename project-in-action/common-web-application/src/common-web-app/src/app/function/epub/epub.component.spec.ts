import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EpubComponent } from './epub.component';

describe('EpubComponent', () => {
  let component: EpubComponent;
  let fixture: ComponentFixture<EpubComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ EpubComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(EpubComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
