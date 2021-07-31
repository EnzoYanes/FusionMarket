export interface Order {
    id: number;
    statusId: number;
    status: string;
    createdDate: Date;
    name: string;
    totalPrice: number;
}
