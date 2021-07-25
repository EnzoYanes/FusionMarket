export interface Product {
    id: number;
    name: string;
    description: string;
    price: number
}

export interface ProductsPaginated{
    products: Product[];
    totalRow: number;
}