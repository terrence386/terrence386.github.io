# Method 装饰器
@Method（）装饰器用于暴露公共API上的方法用@Method（）装饰器修饰的函数可以直接从元素调用，也就是说，它们可以从外部调用！

*开发人员应该尽量少依赖公开的方法，而应该尽量默认使用属性和事件。随着应用程序的扩展，我们发现通过@Prop而不是公共方法管理和传递数据更容易。*
```
import { Method } from '@stencil/core';

export class TodoList {

  @Method()
  async showPrompt() {
    // show a prompt
  }
}
```
调用 
```
const todoListElement = document.querySelector('todo-list');
todoListElement.showPrompt();
```
#####  公共方法必须异步
Stencil的体系结构在所有级别上都是异步的，这允许许多性能优势和易用性。通过使用@Method decorator确保公开公开的方法返回一个promise：

 - 开发人员可以在没有componentOnReady（）的情况下下载实现之前调用方法，componentOnReady（）将方法调用排队，并在组件完成加载后解析。

 - 无论是仍然需要延迟加载，还是已经完全水合，与组件的交互作用都是相同的。

 - 通过保持组件的公共API异步，应用程序可以将组件透明地移动到Web Worker，而API仍然是相同的。

 - 只有具有@Method decorator的公开公开方法才需要返回promise。所有其他组件方法都是该组件的私有方法，不需要异步。

```
// VALID: using async
@Method()
async myMethod() {
  return 42;
}

// VALID: using Promise.resolve()
@Method()
myMethod2() {
  return Promise.resolve(42);
}

// VALID: even it returns nothing, it needs to be async
@Method()
async myMethod3() {
  console.log(42);
}

// INVALID
@Method()
notOk() {
  return 42;
}
```
#####  私有方法
私有方法仍然可以用于组织组件的业务逻辑，并且它们不必返回承诺。
```
class Component {
  // Since `getData` is not a public method exposed with @Method
  // it does not need to be async
  getData() {
    return this.someData;
  }
  render() {
    return (
      <div>{this.getData()}</div>
    );
  }
}
```