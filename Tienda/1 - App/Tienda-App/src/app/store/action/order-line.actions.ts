import { createAction, props } from '@ngrx/store';
import { Product } from 'src/app/Interfaces/product';

export const addOrderLine = createAction('[OrderLine] Add OrderLine', (orderLine: Product) => ({orderLine}));

export const removeOrderLine = createAction('[OrderLine] Remove an OrderLine from list', props<{productId: number}>());

export const setOrderList = createAction('[OrderLine] set Order List', props<{orderList: Product[]}>());

export const resetOrderList = createAction('[OrderLine] Reset Order List');