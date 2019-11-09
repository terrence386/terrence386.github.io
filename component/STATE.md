# State 装饰器
@State（）装饰器可用于管理组件的内部数据。这意味着用户不能从组件外部修改此数据，但是组件可以根据自己的需要修改它。对@State（）属性的任何更改都将导致再次调用组件呈现函数。
##### demo
这个例子使用了State和Listen修饰符。我们定义了一个名为open的类属性，并用@State装饰它。使用@Listener，我们可以通过切换open的值来响应click事件。
```
import { Component, State, Listen, h } from '@stencil/core';

@Component({
  tag: 'my-toggle-button'
})

export class MyToggleButton {
  @State() open: boolean;

  @Listen('click', { capture: true })
  handleClick() {
    this.open = !this.open;
  }

  render() {
    return <button>
      {this.open ? "On" : "Off"}
    </button>;
  }
}
```
对于更高级的用例，状态可以是复杂类型。在下面的示例中，我们维护一个Todo类型值的列表。
```
import { State } from '@stencil/core';

type Todo = {
  done: boolean,
  description: string,
}

export class TodoList {

  @State() completedTodos: Todo[];

  completeTodo(todo: Todo) {
    // This will cause our render function to be called again
    this.completedTodos = [...this.completedTodos, todo];
  }
}
```
##### 何时使用？
并非所有内部状态都需要用@state（）修饰，实际上，如果您确定值不会更改或不需要触发重新呈现，则最好避免使用它：
```
class Component {

  // If `cacheData` changes we don't want to re-render the component,
  // so we DON'T decorate it with @State
  cacheData = SOME_BIG_DATA;

  // If this state change we want to run render() again
  @State() value;
}
```