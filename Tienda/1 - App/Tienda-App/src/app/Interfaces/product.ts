export interface Product {
    id: number;
    name: string;
    description: string;
    price: number;
    itemNumbers: number;
}

export interface ProductsPaginated{
    products: Product[];
    totalRow: number;
}