# function component 使用函数组件
函数组件与普通的模板web组件有很大的不同，因为它们是模板JSX编译器的一部分功能组件基本上是一个接受props对象并将其转换为JSX的函数。

```
const Hello = props => <h1>Hello, {props.name}!</h1>;
```
当JSX 解释器遇到这样的组件时，它将获取其属性，将它们作为props对象传递到函数中，并用函数返回的JSX替换该组件。

```
<Hello name="World" />
```
函数组件还接受第二个参数子项。
```
const Hello = (props, children) => [
  <h1>Hello, {props.name}</h1>,
  children
];
```
JSX 将组件的所有子元素作为数组传递到函数的子参数中。
```
<Hello name="World">
  <p>I'm a child element.</p>
</Hello>
```
Stencil提供了功能组件泛型类型，允许为组件的属性指定接口
```
// Hello.tsx

import { FunctionalComponent, h } from '@stencil/core';

interface HelloProps {
  name: string;
}

export const Hello: FunctionalComponent<HelloProps> = ({ name }) => (
  <h1>Hello, {name}!</h1>
);
```
函数组件和类组件之间有一些主要的区别。由于函数组件只是JSX中的语法糖，所以它们。。。
 - 没有编译成web组件，
 - 不要创建DOM节点，
 - 没有阴影DOM或范围样式，
 - 没有生命周期挂钩，
 - 是无状态的。

在决定是否使用函数组件时，需要记住的一个概念是，应用程序的UI通常是其状态的函数，即，给定相同的状态，它总是呈现相同的UI。如果一个组件必须保持状态、处理事件等，那么它可能应该是一个类组件如果组件的目的是简单地封装一些标记，以便在应用程序中重用，那么它可能是一个函数组件（特别是如果您正在使用组件库，因此不需要设置其样式）