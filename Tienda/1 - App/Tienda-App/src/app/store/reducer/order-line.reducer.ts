import { Action, createReducer, on } from '@ngrx/store';
import { Product } from 'src/app/Interfaces/product';
import { addOrderLine, removeOrderLine, resetOrderList, setOrderList } from '../action/order-line.actions';

export const orderLineFeatureKey = 'orderLine';

export interface OrderLineState {
  orderLines: Product[];
}

export const initialState: OrderLineState = {
  orderLines: []
};

export const orderLineReducer = createReducer(
  initialState,
  //on(addOrderLine, (state, {orderLine}) => ({...state, orderLines: [...state.orderLines, orderLine]})),
  on(addOrderLine, (state, {orderLine}) => {
    if (!state.orderLines.some(p => p.id == orderLine.id)) {
      return ({orderLines: [...state.orderLines, orderLine]})
    }
    return ({orderLines: [...state.orderLines]})
  }),
  on(removeOrderLine, (state, {productId}) => ({orderLines: state.orderLines.filter(p => p.id !== productId)})),
  on(setOrderList, (state, {orderList}) => ({orderLines: orderList})),
  on(resetOrderList, state => initialState)
);

export function reducer(state: OrderLineState | undefined, action: Action): any {
  return orderLineReducer(state, action);
}