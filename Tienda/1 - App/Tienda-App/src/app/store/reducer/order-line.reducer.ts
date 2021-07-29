import { Action, createReducer, on } from '@ngrx/store';
import { Product } from 'src/app/Interfaces/product';
import * as OrderLineActions from "../action/order-line.actions";

export const orderLineFeatureKey = 'orderLine';

export interface OrderLineState {
  orderLines: Product[];
}

export const initialState: OrderLineState = {
  orderLines: []
};

export const orderLineReducer = createReducer(
  initialState,
  on(OrderLineActions.addOrderLine,
    (state: OrderLineState, {orderLine}) =>
    ({...state, orderLines: [...state.orderLines, orderLine]}))
);


export function reducer(state: OrderLineState | undefined, action: Action): any {
  return orderLineReducer(state, action);
}