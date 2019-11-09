# 事件
没有模板事件，相反，Stencli鼓励使用DOM事件。但是，Stencil确实提供了一个API来指定组件可以发出的事件以及组件侦听的事件。它是通过Event（）和Listen（）装饰器来实现的。
##### Event（）装饰器
组件可以使用事件发射器装饰器发出数据和事件。

要为其他组件分派自定义DOM事件以进行处理，请使用@Event（）装饰器。
```
import { Event, EventEmitter } from '@stencil/core';

...
export class TodoList {

  @Event() todoCompleted: EventEmitter;

  todoCompletedHandler(todo: Todo) {
    this.todoCompleted.emit(todo);
  }
}
```
上面的代码将发送一个名为todoCompleted的自定义DOM事件。
事件（opts:Event options）装饰器可以选择接受options对象来塑造已调度事件的行为。选项和默认值如下所述
```
export interface EventOptions {
  /**
   * A string custom event name to override the default.
   */
  eventName?: string;
  /**
   * A Boolean indicating whether the event bubbles up through the DOM or not.
   */
  bubbles?: boolean;

  /**
   * A Boolean indicating whether the event is cancelable.
   */
  cancelable?: boolean;

  /**
   * A Boolean value indicating whether or not the event can bubble across the boundary between the shadow DOM and the regular DOM.
   */
  composed?: boolean;
}
```
Example:
```
import { Event, EventEmitter } from '@stencil/core';

...
export class TodoList {

  // Event called 'todoCompleted' that is "composed", "cancellable" and it will bubble up!
  @Event({
    eventName: 'todoCompleted',
    composed: true,
    cancelable: true,
    bubbles: true,
  }) todoCompleted: EventEmitter;

  todoCompletedHandler(todo: Todo) {
    this.todoCompleted.emit(todo);
  }
}
```
##### Listen Decorator
Listen（）decorator用于监听DOM事件，包括从@events发出的事件。
在下面的示例中，假设子组件TodoList使用EventEmitter发出todoCompleted事件。
```
import { Listen } from '@stencil/core';

...
export class TodoApp {

  @Listen('todoCompleted')
  todoCompletedHandler(event: CustomEvent) {
    console.log('Received the custom todoCompleted event: ', event.detail);
  }
}
```
##### Listen's options
@Listen（事件名，opts？：ListenOptions）包含第二个可选参数，可用于配置如何附加DOM事件侦听器。
```
export interface ListenOptions {
  target?: 'parent' | 'body' | 'document' | 'window';
  capture?: boolean;
  passive?: boolean;
}
```
参数 target, capture and passive
###### target
处理程序也可以为主机本身以外的事件注册。target选项可用于更改事件侦听器的附加位置，这对于侦听应用程序范围的事件非常有用。
在下面的示例中，我们将侦听从窗口发出的滚动事件：
```
@Listen('scroll', { target: 'window' })
  handleScroll(ev) {
    console.log('the body was scrolled', ev);
  }
```
##### passive 
默认情况下，Stencli使用多种启发式方法来确定是否必须附加被动事件侦听器。使用被动选项可用于更改默认行为。
##### capture
默认情况下，与@Listen连接的事件侦听器不会“捕获”。当事件侦听器设置为“捕获”时，意味着事件将在“捕获阶段”被分派，请查看[https://www.quirksmode.org/js/events_order.html](https://www.quirksmode.org/js/events_order.html)以了解更多信息。
##### 键盘事件
对于键盘事件，可以使用@Listen（）中的标准keydown事件，并使用event.key code或event.which获取键代码，或event.key获取键的字符串表示形式。
```
@Listen('keydown')
handleKeyDown(ev: KeyboardEvent){
  if (ev.key === 'ArrowDown'){
    console.log('down arrow pressed')
  }
}
```
#####  JSX中的事件
在模板编译的应用程序或组件中，还可以将侦听器直接绑定到JSX中的事件。这与普通的DOM事件（如onClick）非常相似。
让我们从上面使用TodoList组件：
```
import { Event, EventEmitter } from '@stencil/core';

...
export class TodoList {

  @Event() todoCompleted: EventEmitter;

  todoCompletedHandler(todo: Todo) {
    this.todoCompleted.emit(todo);
  }
}
```
现在，我们可以使用以下语法在JSX中的组件上直接侦听此事件：
```
<todo-list onTodoCompleted={ev => this.someMethod(ev)} />
```
##### 从非JSX元素监听事件
```
<todo-list></todo-list>
<script>
  const todoListElement = document.querySelector('todo-list');
  todoListElement.addEventListener('todoCompleted', event => { /* your listener */ })
</script>
```