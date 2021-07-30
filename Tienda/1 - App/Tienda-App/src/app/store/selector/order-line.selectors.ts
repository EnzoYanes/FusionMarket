import { createFeatureSelector, createSelector } from '@ngrx/store';
import * as fromOrderLine from "../reducer/order-line.reducer";

export const selectOrderLineState = createFeatureSelector<fromOrderLine.OrderLineState>(fromOrderLine.orderLineFeatureKey);

export const selectOrderLines = createSelector(selectOrderLineState, (state: fromOrderLine.OrderLineState) => state.orderLines);