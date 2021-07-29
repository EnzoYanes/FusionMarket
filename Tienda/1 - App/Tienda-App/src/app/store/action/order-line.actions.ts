import { createAction, props } from '@ngrx/store';
import { Product } from 'src/app/Interfaces/product';

export const addOrderLine = createAction(
  '[OrderLine] Add OrderLine',
  (orderLine: Product) => ({orderLine})
);
