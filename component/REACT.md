# 响应式数据
当组件上的道具或状态更改时，Stencli组件将更新。为了提高性能和简单性，Stencli只比较更改的引用，并且不会在数组或对象内部的数据更改时重新呈现。
##### rendering 方法
当组件因状态更改（props或state change）而更新时，render（）方法将计划运行。
##### Watch 装饰器
当用户更新属性时，Watch将启动它所附加的任何方法，并将prop的新值与旧值一起传递给该方法。手表是有用的验证道具或处理副作用。当组件最初加载时，Watch decorator不会触发。
```
import { Prop, Watch } from '@stencil/core';

export class LoadingIndicator {
  @Prop() activated: boolean;

  @Watch('activated')
  watchHandler(newValue: boolean, oldValue: boolean) {
    console.log('The new value of activated is: ', newValue);
  }
}
```
##### 数组和对象
要更新数组或对象数据，请使用以下技术，这些技术正迅速成为现代JavaScript工具箱的核心部分。
##### 数组
对于数组，这意味着标准的可变数组操作（如push（）和unshift（））将不起作用。相反，在返回新数组的副本时，应使用不可变的数组运算符，如map（）和filter（），以及ES6 spread运算符语法。

例如，将一个新的项目推送到一个数组中，创建一个新数组，其中包含现有值和新值：
```
// our original array
this.items = ['ionic', 'stencil', 'webcomponents'];

// update the array
this.items = [
  ...this.items,
  'awesomeness'
]
```
##### 对象
扩展运算符也应该用于更新对象。与数组一样，更改对象不会触发模具中的视图更新，但返回对象的新副本会。下面是一个例子：
```
// our original object
let myCoolObject = {first: '1', second: '2'}

// update our object
myCoolObject = { ...myCoolObject, third: '3' }
```
