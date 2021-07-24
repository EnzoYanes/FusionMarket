import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { MatTableDataSource } from '@angular/material/table';
import { Category } from 'src/app/Interfaces/category';
import { Product } from 'src/app/Interfaces/product';
import { CategoryService } from 'src/app/services/category.service';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.scss']
})
export class ProductListComponent implements OnInit {

  products: Product[] = [];
  displayedColumns: string[] = ['id','name','description','price'];
  categories: Category[] = [];
  length = 100;
  pageSize = 10;
  pageSizeOptions: number[] = [5,10,25,50];

  constructor(private _productService: ProductService,
    private _categoryService: CategoryService,
    public fb: FormBuilder) { }
    
  filterForm = this.fb.group({
    selectedCategory: [''],
    searchInput: ['']
  })

  ngOnInit() {
    this.getProducts(this.pageSize.toString(), '', '0');
    this.getCategories();
  }

  changeFilter() {
    this.getProducts(this.pageSize.toString(), this.searchInput?.value, this.selectedCategory?.value);
  }

  get selectedCategory() {
    return this.filterForm.get('selectedCategory');
  }

  get searchInput() {
    return this.filterForm.get('searchInput');
  }

  getCategories(): void {
    this._categoryService.getCategories().subscribe(data => this.categories = data);
  }

  getProducts(pageSize: string, name: string, categoryId: string): void {
    this._productService.getProducts(pageSize, name, categoryId).subscribe(data => {
      this.products = data;
      this.length = data.length;
    });
  }
}