import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { PageEvent } from '@angular/material/paginator';
import { Sort } from '@angular/material/sort';
import { Store } from '@ngrx/store';
import { Category } from 'src/app/Interfaces/category';
import { Product } from 'src/app/Interfaces/product';
import { CategoryService } from 'src/app/services/category.service';
import { ProductService } from 'src/app/services/product.service';
import { addOrderLine } from 'src/app/store/action/order-line.actions';
import { OrderLineState } from 'src/app/store/reducer/order-line.reducer';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.scss']
})
export class ProductListComponent implements OnInit {

  products: Product[] = [];
  displayedColumns: string[] = ['id','name','description','price','add'];
  categories: Category[] = [];
  length = 100;
  pageIndex = 0;
  pageSize = 10;
  pageSizeOptions: number[] = [5,10,25,50];
  orderBy:string = 'name';
  ascORdesc:string = 'asc';

  constructor(private _productService: ProductService,
    private _categoryService: CategoryService,
    public fb: FormBuilder,
    private store: Store<OrderLineState>) { }
    
  filterForm = this.fb.group({
    selectedCategory: ['0'],
    searchInput: ['']
  })

  ngOnInit() {
    this.getProducts(this.pageIndex, this.pageSize, '', '0', this.orderBy, this.ascORdesc);
    this.getCategories();
  }

  btnAdd_Click(item: Product){
    let prod: Product;
    prod = {
      name: item.name,
      description: item.description,
      id: item.id,
      itemNumbers: item.itemNumbers,
      price: item.price
    }
    this.store.dispatch(addOrderLine(prod));
    item.itemNumbers = 0;
  }

  changeFilter() {
    this.pageIndex = 0;
    this.getProducts(this.pageIndex, this.pageSize, this.searchInput?.value, this.selectedCategory?.value, this.orderBy, this.ascORdesc);
  }

  get selectedCategory() {
    return this.filterForm.get('selectedCategory');
  }

  get searchInput() {
    return this.filterForm.get('searchInput');
  }

  getPaginatorData(event: PageEvent) {
    this.pageSize = event.pageSize;
    this.pageIndex = event.pageIndex;
    this.getProducts(this.pageIndex, this.pageSize, this.searchInput?.value, this.selectedCategory?.value, this.orderBy, this.ascORdesc);
  }

  sortChanged(sort: Sort){
    this.orderBy = sort.active;
    this.ascORdesc = sort.direction;
    this.changeFilter();
  }

  getCategories(): void {
    this._categoryService.getCategories().subscribe(data => this.categories = data);
  }

  getProducts(pageIndex:number, pageSize:number, name: string, categoryId: string, orderBy:string, ascORdesc:string): void {
    this._productService.getProducts(pageIndex, pageSize, name, categoryId, orderBy, ascORdesc).subscribe(data => {
      this.products = data.products;
      this.length = data.totalRow;
    });
  }
}