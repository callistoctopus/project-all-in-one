import { ComponentFixture, TestBed } from '@angular/core/testing';

import { QualityIndexComponent } from './quality-index.component';

describe('QualityIndexComponent', () => {
  let component: QualityIndexComponent;
  let fixture: ComponentFixture<QualityIndexComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ QualityIndexComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(QualityIndexComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
