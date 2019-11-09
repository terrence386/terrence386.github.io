# HOST 
组件使用JSX在其render方法中以声明方式呈现其子组件。大多数情况下，render（）函数描述即将呈现的子元素，但它也可以用于呈现宿主元素本身的属性。
##### `<Host>`
Host函数组件可以在render函数的根目录下使用，以将属性和事件侦听器设置为Host元素本身。这和其他JSX一样工作：
```
// Host is imported from '@stencil/core'
import { Component, Host, h } from '@stencil/core';

@Component({tag: 'todo-list'})
export class TodoList {
  @Prop() open = false;
  render() {
    return (
      <Host
        aria-hidden={this.open ? 'false' : 'true'}
        class={{
          'todo-list': true,
          'is-open': this.open
        }}
      />
    )
  }
}
```
`this.open === true`
```
<todo-list class="todo-list is-open" aria-hidden="false"></todo-list>
```
`<Host>`是一个虚拟组件，一个由模板公开的虚拟API，用于声明性地设置主机元素的属性，它永远不会在DOM中呈现，例如，在Chrome开发工具中，您永远不会看到`<Host>`。
##### `<Host> can work as a <Fragment>`
`<Host>` 也可以在需要在根节点render多个组件时使用，例如：
```
@Component({tag: 'my-cmp'})
export class MyCmp {
  render() {
    return (
      <Host>
        <h1>Title</h1>
        <p>Message</p>
      </Host>
    );
  }
}
```
# Element Decorator 
@Element（）decorator是如何访问类实例中的宿主元素的。这将返回HTMLElement的一个实例，因此可以在这里使用标准的DOM方法/事件。
```
import { Element } from '@stencil/core';

...
export class TodoList {

  @Element() el: HTMLElement;

  getListHeight(): number {
    return this.el.getBoundingClientRect().height;
  }
}
```
如果需要更新宿主元素以响应属性或状态更改，则应使用`<host>`元素在render（）方法中进行更新。
# 样式
```
@Component({
  tag: 'my-cmp',
  styleUrl: 'my-cmp.css'
})
```
# shadow Dom
需要注意的是，在使用shadow DOM时设置`<Host>`元素的样式并不完全一样。您必须：host，而不是使用我的cmp元素选择器。
```
@Component({
  tag: 'my-cmp',
  styleUrl: 'my-cmp.css',
  shadow: true
})```